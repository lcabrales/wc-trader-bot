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

DEFAULT_COUNTDOWN_THRESHOLD = 3
THRESHOLD_KEY = "threshold"

COUNTDOWN_MINUTES_DELAY = 60

COUNTDOWN_QUERY = """
SELECT piece.id, piece.name, user_piece.user_id AS user_id
FROM piece
JOIN map ON piece.map_id = map.id
JOIN user_piece ON piece.id = user_piece.piece_id
WHERE map.id = ? AND user_piece.status = ? 
ORDER BY map.name, piece.order_by ASC;
"""

COLOUR_DEFAULT = 0x0058F2


class Eternal(Cog):
	def __init__(self, client):
		self.client = client

	@staticmethod
	def array_to_string(array):
		return ', '.join(array)

	@group(invoke_without_command=True)
	@has_permissions(manage_guild=True)
	async def eternal(self, ctx):
		await ctx.send(f'Please specify the piece command')

	@eternal.error
	async def eternal_error(self, ctx, exc):
		if isinstance(exc, CheckFailure):
			await ctx.send("You need the Manage Server permission to do that.")

	async def create_countdown_embed(self, threshold):
		world_abbv_list = db.column("SELECT abbv FROM world")

		embed_description = ""
		previous_world_id = None
		for world_abbv in world_abbv_list:
			(world_id, world_name) = db.record("SELECT id, name FROM world WHERE abbv = ?", world_abbv)

			world_map_list = db.column("SELECT id FROM map WHERE world_id = ?", world_id)

			for map_id in world_map_list:
				pieces_seeking = db.records(COUNTDOWN_QUERY, map_id, STATUS_SEEKING)
				
				if not pieces_seeking:
					continue

				if previous_world_id and previous_world_id != world_id:
					# extra space between different worlds
					embed_description += "\n" 

				# Sort the data based on the third value (user_id) for groupby to work properly
				sorted_data = sorted(pieces_seeking, key=lambda x: x[2])

				# Group the data by the third value (user_id) and create separate arrays for each user_id
				user_id_arrays = {}
				for key, group in groupby(sorted_data, key=lambda x: x[2]):
					user_id_arrays[key] = list(group)

				# Now iterate through user_id_arrays for each user_id
				for user_id, user_data in user_id_arrays.items():
					if len(user_data) > threshold:
						continue

					embed_description += f"* {world_name} "

					piece_names = []
					for data_item in user_data:
						piece_names.append(data_item[1])

					embed_description += f"{self.array_to_string(piece_names)} "

					try:
						member = await self.client.fetch_user(user_id)
						embed_description += f"({member.display_name})"
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
		
		embed = await self.create_countdown_embed(threshold)

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
				print(f"Caught exception at show_countdow {exc}")
			
			db.execute("DELETE FROM eternal WHERE message_id = ?", existing_message_id)

		print("updating eternal countdown...")
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
				print(f"Caught exception at show_countdow {exc}")
			
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
				embed = await self.create_countdown_embed(threshold)
				await message.edit(embed=embed)
			except Exception as exc:
				print(f"Caught exception at countdown {exc}")
				continue

	@Cog.listener()
	async def on_ready(self):
		if not self.client.ready:
			self.client.cogs_ready.ready_up("eternal")
		
		self.countdown.start()

async def setup(client):
	await client.add_cog(Eternal(client))