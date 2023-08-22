from random import choice, randint
from typing import Optional

from datetime import datetime
from uuid import uuid4

from itertools import groupby

from discord import Member, Embed
from discord.ext.tasks import loop
from discord.ext.commands import Cog
from discord.ext.commands import BadArgument, CheckFailure
from discord.ext.commands import command, cooldown, group, has_permissions

from ..db import db


STATUS_NONE = -1 # not for db
STATUS_SEEKING = 0
STATUS_OWNED = 1
STATUS_TRADE = 2

TYPE_COUNTDOWN = "d6e2f67d-1756-4a6d-918c-89408f13e252"
TYPE_USERS_MAP_COUNT = "8712a0fa-0eae-47ef-9f5e-023e30e35ce1"

DEFAULT_COUNTDOWN_THRESHOLD = 3
THRESHOLD_KEY = "threshold"

COUNTDOWN_MINUTES_DELAY = 60
USERS_MAP_COUNT_MINUTES_DELAY = 60

COUNTDOWN_QUERY = """
SELECT piece.id, piece.name, user_piece.user_id AS user_id
FROM piece
JOIN map ON piece.map_id = map.id
JOIN user_piece ON piece.id = user_piece.piece_id
WHERE map.id = ? AND user_piece.status = ? 
ORDER BY map.name, piece.order_by ASC;
"""

USERS_MAP_COUNT_QUERY = """
SELECT world.name AS world_name, map.name AS map_name, GROUP_CONCAT(DISTINCT user_piece.user_id) AS user_ids
FROM world
JOIN map ON world.id = map.world_id
LEFT JOIN piece ON map.id = piece.map_id
LEFT JOIN user_piece ON piece.id = user_piece.piece_id AND user_piece.status = ?
GROUP BY world.name, map.name;
"""

COLOUR_DEFAULT = 0x0058F2


class Eternal(Cog):
	def __init__(self, client):
		self.client = client

	@staticmethod
	def array_to_string(array):
		return ', '.join(array)
	
	@staticmethod
	def plurals(count, term):
		if not count:
			return "**None**"
		
		return f"**{count} {term}{'s' if count > 1 else ''}**"

	@group(invoke_without_command=True)
	@has_permissions(manage_guild=True)
	async def eternal(self, ctx):
		await ctx.send(f'Please specify the eternal command')

	@eternal.error
	async def eternal_error(self, ctx, exc):
		if isinstance(exc, CheckFailure):
			await ctx.send("You need the Manage Server permission to do that.")

	
	# # # # # #
	# COUNTDOWN
	async def create_countdown_embed(self, threshold, guild):
		world_ids = db.column("SELECT id FROM world ORDER BY name")

		embed_description = f"Shows the users seeking {threshold} or less pieces of a certain map.\n\n"

		previous_world_id = None
		for world_id in world_ids:
			world_name = db.field("SELECT name FROM world WHERE id = ?", world_id)

			world_map_list = db.column("SELECT id FROM map WHERE world_id = ?", world_id)

			for map_id in world_map_list:
				pieces_seeking = db.records(COUNTDOWN_QUERY, map_id, STATUS_SEEKING)

				if not pieces_seeking:
					continue

				# Sort the data based on the third value (user_id) for groupby to work properly
				sorted_data = sorted(pieces_seeking, key=lambda x: x[2])

				# Group the data by the third value (user_id) and create separate arrays for each user_id
				user_id_arrays = {}
				for key, group in groupby(sorted_data, key=lambda x: x[2]):
					user_id_arrays[key] = list(group)

				# Now iterate through user_id_arrays for each user_id
				for user_id, user_data in user_id_arrays.items():
					if not user_data or len(user_data) > threshold:
						continue

					if previous_world_id and previous_world_id != world_id:
						# extra space between different worlds
						embed_description += "\n"
						previous_world_id = None

					embed_description += f"* **{world_name} "

					piece_names = []
					for data_item in user_data:
						piece_names.append(data_item[1])

					embed_description += f"{self.array_to_string(piece_names)}:** "

					try:
						member = guild.get_member(user_id)
						embed_description += f"{member.display_name}"
					except Exception as exc:
						print(f"Caught exception at show_countdow {exc}")
				
					embed_description += "\n"

			previous_world_id = world_id

		embed_title = f"Countdown Summary"
		embed_colour = COLOUR_DEFAULT
		embed_footer = "Last updated"

		embed = Embed(
			title=embed_title, 
			description=embed_description, 
			colour=embed_colour, 
			timestamp=datetime.now()
		)
		embed.set_footer(text=embed_footer)

		return embed
	
	@eternal.command(name="countdown", aliases=["cd"])
	@has_permissions(manage_guild=True)
	async def show_countdown(self, ctx, threshold: Optional[int] = DEFAULT_COUNTDOWN_THRESHOLD):
		if threshold < 1 or threshold > 20:
			await ctx.send(f'Bad argument: {threshold} - must be between 1 and 20')
			raise BadArgument("threshold must be between 1 and 20")
		
		guild = ctx.message.guild
		
		# only one message per guild of each type
		existing_message_id = db.field("SELECT message_id FROM eternal WHERE guild_id = ? AND eternal_type_id = ?", 
			guild.id, TYPE_COUNTDOWN)

		# delete the previous message so we stop updating it
		if existing_message_id:
			channel_id = db.field("SELECT channel_id FROM eternal WHERE message_id = ?", existing_message_id)

			try:
				channel = self.client.get_channel(channel_id)

				if channel:
					message = await channel.fetch_message(existing_message_id)

				await message.delete()
			except Exception as exc:
				print(f"Caught exception at show_countdow {exc}")
			
			db.execute("DELETE FROM eternal WHERE message_id = ?", existing_message_id)

		print("updating eternal countdown...")
		embed = await self.create_countdown_embed(threshold, guild)
		message = await ctx.send(embed=embed)

		# delete original author message (the one that issued the command)
		await ctx.message.delete()

		db.execute("INSERT INTO eternal (message_id, channel_id, guild_id, eternal_type_id) VALUES (?, ?, ?, ?);", 
	     	message.id, message.channel.id, message.guild.id, TYPE_COUNTDOWN)
		db.execute("INSERT INTO eternal_params (id, key, value, eternal_id) VALUES (?, ?, ?, ?)",
	     	str(uuid4()), THRESHOLD_KEY, threshold, message.id)
		db.commit()

	@show_countdown.error
	async def show_countdown_error(self, ctx, exc):
		if isinstance(exc, CheckFailure):
			await ctx.send("You need the Manage Server permission to do that.")

	@eternal.command(name="countdownrm", aliases=["cdrm"])
	@has_permissions(manage_guild=True)
	async def remove_countdown(self, ctx):
		# only one message per guild of each type
		existing_message_id = db.field("SELECT message_id FROM eternal WHERE guild_id = ? AND eternal_type_id = ?", 
			ctx.message.guild.id, TYPE_COUNTDOWN)

		# delete the previous message so we stop updating it
		if existing_message_id:
			channel_id = db.field("SELECT channel_id FROM eternal WHERE message_id = ?", existing_message_id)

			try:
				channel = self.client.get_channel(channel_id)

				if channel:
					message = await channel.fetch_message(existing_message_id)

				await message.delete()
			except Exception as exc:
				print(f"Caught exception at show_countdown {exc}")
			
			db.execute("DELETE FROM eternal WHERE message_id = ?", existing_message_id)

			db.commit()

		# delete original author message (the one that issued the command)
		await ctx.message.delete()

	@remove_countdown.error
	async def remove_countdown_error(self, ctx, exc):
		if isinstance(exc, CheckFailure):
			await ctx.send("You need the Manage Server permission to do that.")

	@loop(minutes=COUNTDOWN_MINUTES_DELAY)
	async def countdown(self):
		message_ids = db.column("SELECT message_id FROM eternal WHERE eternal_type_id = ?", TYPE_COUNTDOWN)

		if not message_ids:
			return

		for message_id in message_ids:
			try:
				channel_id = db.field("SELECT channel_id FROM eternal WHERE message_id = ?", message_id)

				channel = self.client.get_channel(channel_id)

				if not channel:
					continue

				message = await channel.fetch_message(message_id)

				if not message:
					continue

				threshold = int(db.field("SELECT value FROM eternal_params WHERE eternal_id = ? and key = ?", message_id, THRESHOLD_KEY))
				embed = await self.create_countdown_embed(threshold, message.guild)
				await message.edit(embed=embed)
			except Exception as exc:
				print(f"Caught exception at countdown {exc}")
				continue

	# # # # # #
	# User's Maps Count
	async def create_users_maps_embed(self, guild):
		embed_description = "Users that are seeking at least one piece of a certain map.\n\n"

		map_count_result = db.records(USERS_MAP_COUNT_QUERY, STATUS_SEEKING)

		if not map_count_result:
			return

		current_world = None
		for row in map_count_result:
			world_name, map_name, user_ids_str = row

			user_ids = [int(user_id) for user_id in user_ids_str.split(',')] if user_ids_str else []

			if not user_ids:
				continue

			if current_world != world_name:
				if current_world is not None:
					embed_description += "\n"  # Line break after each world
				current_world = world_name

			user_names = []
			for user_id in user_ids:
				try:
					member = guild.get_member(user_id)
					user_names.append(member.display_name)
				except Exception as exc:
					print(f"Caught exception at show_countdow {exc}")
					continue

			embed_description += f"* **{world_name} {map_name}:** {self.array_to_string(user_names)}\n"

		embed_title = f"Trader's Map Count"
		embed_colour = COLOUR_DEFAULT
		embed_footer = "Last updated"

		embed = Embed(
			title=embed_title, 
			description=embed_description, 
			colour=embed_colour, 
			timestamp=datetime.now()
		)
		embed.set_footer(text=embed_footer)

		return embed
	
	@eternal.command(name="mapcount")
	@has_permissions(manage_guild=True)
	async def show_users_map_count(self, ctx):
		guild = ctx.message.guild

		# only one message per guild of each type
		existing_message_id = db.field("SELECT message_id FROM eternal WHERE guild_id = ? AND eternal_type_id = ?", 
			guild.id, TYPE_USERS_MAP_COUNT)

		# delete the previous message so we stop updating it
		if existing_message_id:
			channel_id = db.field("SELECT channel_id FROM eternal WHERE message_id = ?", existing_message_id)

			try:
				channel = self.client.get_channel(channel_id)

				if channel:
					message = await channel.fetch_message(existing_message_id)

				await message.delete()
			except Exception as exc:
				print(f"Caught exception at show_countdow {exc}")
			
			db.execute("DELETE FROM eternal WHERE message_id = ?", existing_message_id)

		print("updating eternal users map count...")
		embed = await self.create_users_maps_embed(guild)
		message = await ctx.send(embed=embed)

		# delete original author message (the one that issued the command)
		await ctx.message.delete()

		db.execute("INSERT INTO eternal (message_id, channel_id, guild_id, eternal_type_id) VALUES (?, ?, ?, ?);", 
	     	message.id, message.channel.id, message.guild.id, TYPE_USERS_MAP_COUNT)
		db.commit()

	@show_users_map_count.error
	async def show_users_map_count_error(self, ctx, exc):
		if isinstance(exc, CheckFailure):
			await ctx.send("You need the Manage Server permission to do that.")

	@eternal.command(name="mapcountrm")
	@has_permissions(manage_guild=True)
	async def remove_users_map_count(self, ctx):
		# only one message per guild of each type
		existing_message_id = db.field("SELECT message_id FROM eternal WHERE guild_id = ? AND eternal_type_id = ?", 
			ctx.message.guild.id, TYPE_USERS_MAP_COUNT)

		# delete the previous message so we stop updating it
		if existing_message_id:
			channel_id = db.field("SELECT channel_id FROM eternal WHERE message_id = ?", existing_message_id)

			try:
				channel = self.client.get_channel(channel_id)

				if channel:
					message = await channel.fetch_message(existing_message_id)

				await message.delete()
			except Exception as exc:
				print(f"Caught exception at show_countdow {exc}")
			
			db.execute("DELETE FROM eternal WHERE message_id = ?", existing_message_id)

			db.commit()

		# delete original author message (the one that issued the command)
		await ctx.message.delete()

	@remove_users_map_count.error
	async def remove_users_map_count_error(self, ctx, exc):
		if isinstance(exc, CheckFailure):
			await ctx.send("You need the Manage Server permission to do that.")

	@loop(minutes=USERS_MAP_COUNT_MINUTES_DELAY)
	async def users_map_count(self):
		message_ids = db.column("SELECT message_id FROM eternal WHERE eternal_type_id = ?", TYPE_USERS_MAP_COUNT)

		if not message_ids:
			return

		for message_id in message_ids:
			try:
				channel_id = db.field("SELECT channel_id FROM eternal WHERE message_id = ?", message_id)

				channel = self.client.get_channel(channel_id)

				if not channel:
					continue

				message = await channel.fetch_message(message_id)

				if not message:
					continue

				embed = await self.create_users_maps_embed(message.guild)
				await message.edit(embed=embed)
			except Exception as exc:
				print(f"Caught exception at countdown {exc}")
				continue

	@Cog.listener()
	async def on_ready(self):
		if not self.client.ready:
			self.client.cogs_ready.ready_up("eternal")
		
		self.countdown.start()
		self.users_map_count.start()

async def setup(client):
	await client.add_cog(Eternal(client))