from datetime import datetime
from random import choice, randint
from typing import Optional, Literal
from uuid import uuid4

from aiohttp import request
from discord import Member, Embed, SelectOption, Interaction
from discord.ui import Select, View
from discord.ext.commands import Cog
from discord.ext.commands import BadArgument
from discord.ext.commands import command, group

from ..db import db


HELP_README_URL = "https://gist.github.com/panacea0706/62ce539ea6d5e2b0a2ce606cd8315f25"

STATUS_NONE = -1 # not for db
STATUS_SEEKING = 0
STATUS_OWNED = 1
STATUS_TRADE = 2

COMMAND_STATUS_MAPPING = {
    'owned': STATUS_OWNED,
    'seeking': STATUS_SEEKING,
    'trade': STATUS_TRADE,
    'none': STATUS_NONE
}

COLOUR_SUCCESS = 0x4BB543
COLOUR_DEFAULT = 0x0058F2
COLOUR_ERROR = 0xFF9494

PIECES_OWNED_QUERY = """
SELECT piece.name AS piece_name
FROM piece
JOIN map ON piece.map_id = map.id
JOIN user_piece ON piece.id = user_piece.piece_id
WHERE map.world_id = ? AND user_piece.user_id = ? AND user_piece.status = ?
ORDER BY order_by ASC
"""

PIECES_SEARCH_QUERY = """
SELECT user_piece.user_id
FROM user_piece
JOIN piece ON user_piece.piece_id = piece.id
JOIN map ON piece.map_id = map.id
WHERE map.world_id = ? AND piece.id = ? AND user_piece.status = ?;
"""


class Tracker(Cog):
	def __init__(self, client):
		self.client = client

	def to_upper(argument):
		return argument.upper()
	
	@staticmethod
	def array_to_string(array):
		return ', '.join(array)

	@group(invoke_without_command=True)
	async def piece(self, ctx):
		await ctx.send(f'Please specify the piece command (add, remove, need, trade)')

	@piece.command(name="help")
	async def show_readme_url(self, ctx):
		await ctx.send(HELP_README_URL)

	@piece.command(name="list")
	async def respond_list_command(self, ctx, status: Literal['owned', 'seeking', 'trade'], 
				world_abbv: to_upper, member: Optional[Member] = None):
		status_value = COMMAND_STATUS_MAPPING.get(status, None)
		if status_value is None:
			await ctx.send(f'Bad argument: {status}')
			raise BadArgument
		
		owner = member if member else ctx.author
		is_author_owner = True if member else False

		world_abbv_list = []

		if world_abbv == "ALL":
			worlds = db.column("SELECT abbv FROM world")

			for world in worlds:
				world_abbv_list.append(world)

		else:
			world_abbv_list.append(world_abbv)
		
		fields=[]
		for world_abbv in world_abbv_list:
			(world_id, world_name) = db.record("SELECT id, name FROM world WHERE abbv = ?", world_abbv)
			pieces_owned = db.column(PIECES_OWNED_QUERY, world_id, owner.id, status_value)
			
			if pieces_owned:
				fields.append((world_name, self.array_to_string(pieces_owned), False))
		
		embed_title = "Pieces"
		if status_value is STATUS_OWNED:
			embed_title = "Owned pieces"
		
		elif status_value is STATUS_SEEKING:
			embed_title = "Seeking pieces"

		elif status_value is STATUS_TRADE:
			embed_title = "Trade pieces"

		description_display_name = "your" if not is_author_owner else f"{owner.display_name}'s"

		embed = Embed(
			title=embed_title, 
			description=f"List of pieces in {description_display_name} collection marked as {status}.", 
			colour=COLOUR_DEFAULT, 
			timestamp=None
		)
		for name, value, inline in fields:
			embed.add_field(name=name, value=value, inline=inline)
		
		await ctx.send(embed=embed)

	@piece.command(name="set")
	async def set_piece(self, ctx, status: Literal['owned', 'seeking', 'trade', 'none'], world_abbv: to_upper, *pieces):
		status_value = COMMAND_STATUS_MAPPING.get(status, None)
		if status_value is None:
			await ctx.send(f'Bad argument: {status}')
			raise BadArgument
		
		(world_id, world_name) = db.record("SELECT id, name FROM world WHERE abbv = ?", world_abbv)
		if world_id is None or world_name is None:
			await ctx.send(f'Bad argument: {world_abbv}')
			raise BadArgument
		
		if not pieces:
			await ctx.send(f'Bad argument: {pieces}')
			raise BadArgument
		
		pieces_set = []
		for piece_name in pieces:
			map_name = piece_name[0]
			map_id = db.field("SELECT id FROM map WHERE name = ? AND world_id = ?", map_name, world_id)
			
			piece_id = db.field("SELECT id FROM piece WHERE map_id = ? AND name = ?", map_id, piece_name)
			if piece_id is None:
				continue

			db.execute("INSERT OR IGNORE INTO user_piece (id, piece_id, user_id, status, created_date) VALUES (?,?,?,?,?)", 
						str(uuid4()),
						piece_id,
						ctx.author.id,
						status_value,
						datetime.utcnow())
			
			pieces_set.append(piece_name)

		db.commit()
		
		
		embed_title = world_name
		embed_description = f"Marked the following {world_name} pieces as {status} in your collection:"
		embed_colour = COLOUR_DEFAULT
		embed = Embed(title=embed_title, description=embed_description, 
						colour=embed_colour, timestamp=None)
		embed.add_field(name=status.capitalize(), value=self.array_to_string(pieces_set), inline=False)
		
		await ctx.send(embed=embed)

	@piece.command(name="setall")
	async def set_pieces(self, ctx, status: Literal['owned', 'seeking', 'trade', 'none'], world_abbv: to_upper, 
		      map_name: Literal['1', '2', '3']):
		status_value = COMMAND_STATUS_MAPPING.get(status, None)
		if status_value is None:
			await ctx.send(f'Bad argument: {status}')
			raise BadArgument
		
		(world_id, world_name) = db.record("SELECT id, name FROM world WHERE abbv = ?", world_abbv)
		if world_id is None or world_name is None:
			await ctx.send(f'Bad argument: {world_abbv}')
			raise BadArgument
		
		map_id = db.field("SELECT id FROM map WHERE name = ? AND world_id = ?", map_name, world_id)
		if map_id is None:
				await ctx.send(f'Bad argument: {map_name}')
				raise BadArgument
		
		piece_ids = db.column("SELECT id FROM piece WHERE map_id = ?", map_id)
		for piece_id in piece_ids:
			db.execute("INSERT OR IGNORE INTO user_piece (id, piece_id, user_id, status, created_date) VALUES (?,?,?,?,?)", 
						str(uuid4()),
						piece_id,
						ctx.author.id,
						status_value,
						datetime.utcnow())
			db.commit()
			
		embed_description = f"Marked **all** the pieces for the map {world_name} {map_name} as {status} in your collection"
		embed_colour = COLOUR_SUCCESS

		embed = Embed(title=world_name, description=embed_description, 
						colour=embed_colour, timestamp=None)
		
		await ctx.send(embed=embed)

	@piece.command(name="search")
	async def search_piece(self, ctx, status: Literal['owned', 'seeking', 'trade'], world_abbv: to_upper, piece_name):
		status_value = COMMAND_STATUS_MAPPING.get(status, None)
		if status_value is None:
			await ctx.send(f'Bad argument: {status}')
			raise BadArgument

		(world_id, world_name) = db.record("SELECT id, name FROM world WHERE abbv = ?", world_abbv)
		if world_id is None or world_name is None:
			await ctx.send(f'Bad argument: {world_abbv}')
			raise BadArgument
		
		map_name = piece_name[0]
		map_id = db.field("SELECT id FROM map WHERE name = ? AND world_id = ?", map_name, world_id)
		
		piece_id = db.field("SELECT id FROM piece WHERE map_id = ? AND name = ?", map_id, piece_name)
		if piece_id is None:
			await ctx.send(f'Bad argument: {piece_name}')
			raise BadArgument
		
		user_ids = db.record(PIECES_SEARCH_QUERY, world_id, piece_id, status_value)

		embed_title = f"Server search for {world_name} {piece_name}"
		embed_description = None
		embed_colour = COLOUR_DEFAULT
		embed_fields=[]

		if user_ids:
			user_names=[]
			for user_id in user_ids:
				user = await self.client.fetch_user(user_id)
				user_names.append(user.display_name)

			embed_description = f"{len(user_names)} result{'s' if len(user_names) > 1 else ''} found."
			
			embed_fields.append((status.capitalize(), self.array_to_string(user_names), False))
		
		else:
			embed_description = "No results found."

		embed = Embed(title=embed_title, description=embed_description, 
							colour=embed_colour, timestamp=None)
		
		for name, value, inline in embed_fields:
			embed.add_field(name=name, value=value, inline=inline)

		await ctx.send(embed=embed)

	@Cog.listener()
	async def on_ready(self):
		if not self.client.ready:
			self.client.cogs_ready.ready_up("tracker")


async def setup(client):
	await client.add_cog(Tracker(client))