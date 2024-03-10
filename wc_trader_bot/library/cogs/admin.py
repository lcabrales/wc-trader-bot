from random import choice, randint
from typing import Optional, Literal

from aiohttp import request
from discord import Member, Embed
from discord.ext.commands import Cog
from discord.ext.commands import BadArgument, BucketType, CheckFailure
from discord.ext.commands import command, has_permissions, group

from ..db import db


COLOUR_DEFAULT = 0x0058F2


USER_REMOVE_ALL_PIECES_QUERY = """
DELETE FROM user_piece
WHERE user_id = ?
AND piece_id IN (
    SELECT id
    FROM piece
);
"""

USER_REMOVE_MAP_QUERY = """
DELETE FROM user_piece
WHERE user_id = ?
AND piece_id IN (
    SELECT id
    FROM piece
    WHERE map_id = ?
);
"""


class Admin(Cog):
	def __init__(self, client):
		self.client = client

	def to_upper(argument):
		return argument.upper()

	@command(name="prefix")
	@has_permissions(manage_guild=True)
	async def change_prefix(self, ctx, new: str):
		if len(new) > 5:
			await ctx.send("The prefix can not be more than 5 characters in length.")

		else:
			db.execute("UPDATE guild SET bot_prefix = ? WHERE id = ?", new, ctx.guild.id)
			await ctx.send(f"Prefix set to `{new}`.")

	@change_prefix.error
	async def change_prefix_error(self, ctx, exc):
		if isinstance(exc, CheckFailure):
			await ctx.send("You need the Manage Server permission to do that.")

	@group(invoke_without_command=True)
	@has_permissions(manage_guild=True)
	async def user(self, ctx):
		await ctx.send(f'Please specify the user command')

	@user.error
	async def user_error(self, ctx, exc):
		if isinstance(exc, CheckFailure):
			await ctx.send("You need the Manage Server permission to do that.")

	@user.command(name="clear")
	@has_permissions(manage_guild=True)
	async def clear_user(self, ctx, member: Member):
		if member is None:
			await ctx.send(f'Bad argument: {member}')
			raise BadArgument
		
		await ctx.send("Are you sure you want to run this command? (yes/no)")

		def check(m): # checking if it's the same user and channel
			return m.author == ctx.author and m.channel == ctx.channel

		try: # waiting for message
			response = await self.client.wait_for('message', check=check, timeout=30.0) # timeout - how long bot waits for message (in seconds)
		except TimeoutError: # returning after timeout
			return

		# if response is different than yes / y - return
		if response.content.lower() not in ("yes", "y"):
			return
		
		# confirmation was provided, proceed to remove the pieces

		db.execute(USER_REMOVE_ALL_PIECES_QUERY, member.id)

		embed_title = "Clear user data"
		embed = Embed(
			title=embed_title, 
			description=f"Cleared all user data belonging to **{member.name} ({member.id})**", 
			colour=COLOUR_DEFAULT, 
			timestamp=None
		)
		
		await ctx.send(embed=embed)

	@clear_user.error
	async def clear_user_error(self, ctx, exc):
		if isinstance(exc, CheckFailure):
			await ctx.send("You need the Manage Server permission to do that.")

	@user.command(name="clearmap")
	@has_permissions(manage_guild=True)
	async def clear_user_map(self, ctx, member: Member, world_abbv: to_upper, map_name: Literal['1', '2', '3']):
		if member is None:
			await ctx.send(f'Bad argument: {member}')
			raise BadArgument
		
		await ctx.send("Are you sure you want to run this command? (yes/no)")

		def check(m): # checking if it's the same user and channel
			return m.author == ctx.author and m.channel == ctx.channel

		try: # waiting for message
			response = await self.client.wait_for('message', check=check, timeout=30.0) # timeout - how long bot waits for message (in seconds)
		except TimeoutError: # returning after timeout
			return

		# if response is different than yes / y - return
		if response.content.lower() not in ("yes", "y"):
			return
		
		# confirmation was provided, proceed to execute the command

		(world_id, world_name) = db.record("SELECT id, name FROM world WHERE abbv = ?", world_abbv)
		if world_id is None or world_name is None:
			await ctx.send(f'Bad argument: {world_abbv}')
			raise BadArgument
		
		map_id = db.field("SELECT id FROM map WHERE name = ? AND world_id = ?", map_name, world_id)
		if map_id is None:
			await ctx.send(f'Bad argument: {map_name}')
			raise BadArgument
		
		db.execute(USER_REMOVE_MAP_QUERY, member.id, map_id)
		db.commit()

		embed_title = "Clear user map"
		embed = Embed(
			title=embed_title, 
			description=f"Cleared the map {world_name} {map_name} belonging to **{member.name} ({member.id})**", 
			colour=COLOUR_DEFAULT, 
			timestamp=None
		)
		
		await ctx.send(embed=embed)

	@clear_user.error
	async def clear_user_map_error(self, ctx, exc):
		if isinstance(exc, CheckFailure):
			await ctx.send("You need the Manage Server permission to do that.")

	@Cog.listener()
	async def on_ready(self):
		if not self.client.ready:
			self.client.cogs_ready.ready_up("admin")


async def setup(client):
	await client.add_cog(Admin(client))