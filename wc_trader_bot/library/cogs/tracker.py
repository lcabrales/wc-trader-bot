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


STATUS_NONE = -1 # not for db
STATUS_SEEKING = 0
STATUS_OWNED = 1
STATUS_TRADE = 2

COMMAND_STATUS_MAPPING = {
    'owned': STATUS_OWNED,
    'seeking': STATUS_SEEKING,
    'trade': STATUS_TRADE,
    'none': STATUS_NONE,
    'remove': STATUS_NONE # alias for none
}

COLOUR_SUCCESS = 0x4BB543
COLOUR_DEFAULT = 0x0058F2
COLOUR_ERROR = 0xFF9494

PIECES_USER_STATUS_QUERY = """
SELECT piece.name AS piece_name
FROM piece
JOIN map ON piece.map_id = map.id
JOIN user_piece ON piece.id = user_piece.piece_id
WHERE map.world_id = ? AND user_piece.user_id = ? AND user_piece.status = ? 
ORDER BY map.name, piece.order_by ASC
"""

PIECES_STATUS_ALL_USERS_QUERY = """
SELECT piece.name AS piece_name
FROM piece
JOIN map ON piece.map_id = map.id
JOIN user_piece ON piece.id = user_piece.piece_id
WHERE map.world_id = ? AND user_piece.status = ? 
ORDER BY map.name, piece.order_by ASC
"""

PIECE_USER_REMOVE_QUERY = """
DELETE FROM user_piece
WHERE user_id = ?
AND piece_id = ?;
"""

PIECES_USER_UNNASSIGNED_QUERY = """
SELECT piece.id
FROM piece
JOIN map ON piece.map_id = map.id
LEFT JOIN user_piece ON piece.id = user_piece.piece_id AND user_piece.user_id = ?
WHERE map.id = ?
  AND user_piece.piece_id IS NULL;
"""

PIECES_SEARCH_QUERY = """
SELECT user_piece.user_id
FROM user_piece
JOIN piece ON user_piece.piece_id = piece.id
JOIN map ON piece.map_id = map.id
WHERE map.world_id = ? AND piece.id = ? AND user_piece.status = ?;
"""

MAP_REMOVE_ALL_PIECES_QUERY = """
DELETE FROM user_piece
WHERE user_id = ?
AND piece_id IN (
    SELECT id
    FROM piece
    WHERE map_id = ?
);
"""

MAP_REMOVE_ALL_PIECES_STATUS_QUERY = """
DELETE FROM user_piece
WHERE user_id = ?
AND status = ?
AND piece_id IN (
    SELECT id
    FROM piece
    WHERE map_id = ?
);
"""

MAP_SEARCH_QUERY = """
SELECT DISTINCT user_piece.user_id
FROM piece
JOIN map ON piece.map_id = map.id
JOIN user_piece ON piece.id = user_piece.piece_id
WHERE map.id = ? AND user_piece.status = ? 
ORDER BY map.name, piece.order_by ASC;
"""

class Tracker(Cog):
	def __init__(self, client):
		self.client = client

	def to_upper(argument):
		return argument.upper()
	
	@staticmethod
	def array_to_string(array):
		return ', '.join(array)
	
	@staticmethod
	def plurals_results(results_count):
		return f"{results_count} result{'s' if results_count > 1 else ''} found."

	# # # # # # # #
	# Piece commands

	@group(invoke_without_command=True)
	async def piece(self, ctx):
		await ctx.send(f'Please specify the piece command')

	@piece.command(name="list")
	async def respond_list_command(self, ctx, status: Literal['owned', 'seeking', 'trade'], 
				world_abbv: to_upper, member: Optional[Member] = None):
		status_value = COMMAND_STATUS_MAPPING.get(status, None)
		if status_value is None:
			await ctx.send(f'Bad argument: {status}')
			raise BadArgument
		
		owner = member if member else ctx.author
		is_author_owner = True if ctx.author == owner else False

		world_abbv_list = []

		if world_abbv == "ALL":
			worlds = db.column("SELECT abbv FROM world")
			world_abbv_list.extend(worlds)

		else:
			world_abbv_list.append(world_abbv)
		
		fields=[]
		for world_abbv in world_abbv_list:
			(world_id, world_name) = db.record("SELECT id, name FROM world WHERE abbv = ?", world_abbv)
			pieces_user = db.column(PIECES_USER_STATUS_QUERY, world_id, owner.id, status_value)
			
			if pieces_user:
				fields.append((world_name, self.array_to_string(pieces_user), False))
			
		
		embed_title = "Pieces"
		if status_value is STATUS_OWNED:
			embed_title = "Owned pieces"
		
		elif status_value is STATUS_SEEKING:
			embed_title = "Seeking pieces"

		elif status_value is STATUS_TRADE:
			embed_title = "Trade pieces"

		description_display_name = "your" if is_author_owner else f"{owner.display_name}'s"

		embed = Embed(
			title=embed_title, 
			description=f"List of pieces in **{description_display_name}** collection marked as **{status}**.", 
			colour=COLOUR_DEFAULT, 
			timestamp=None
		)
		for name, value, inline in fields:
			embed.add_field(name=name, value=value, inline=inline)
		
		await ctx.send(embed=embed)

	@piece.command(name="set")
	async def set_piece(self, ctx, status: Literal['owned', 'seeking', 'trade', 'none', 'remove'], world_abbv: to_upper, *pieces):
		owner = ctx.author

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

			pieces_set.append(piece_name)

			# if the status is none/remove
			if status_value == STATUS_NONE:
				db.execute(PIECE_USER_REMOVE_QUERY, owner.id, piece_id)
				continue

			# remove the user piece from seeking if it was set as owned
			if status_value == STATUS_OWNED:
				seeking_user_piece_id = db.field("SELECT up.id FROM piece p INNER JOIN user_piece up ON p.id = up.piece_id WHERE p.id = ? AND status = ? AND up.user_id = ?", 
			  			piece_id, STATUS_SEEKING, owner.id)
				
				if seeking_user_piece_id:
					db.execute("DELETE FROM user_piece WHERE id = ?", seeking_user_piece_id)
			
			# mark the piece as the specified status
			db.execute("INSERT OR IGNORE INTO user_piece (id, piece_id, user_id, status, created_date) VALUES (?,?,?,?,?)", 
						str(uuid4()),
						piece_id,
						owner.id,
						status_value,
						datetime.utcnow())

		db.commit()
		
		
		embed_title = world_name

		if status_value == STATUS_NONE:
			embed_description = f"Removed the following **{world_name}** pieces from your collection:"

		else:
			embed_description = f"Marked the following **{world_name}** pieces as **{status}** in your collection:"

		embed_colour = COLOUR_DEFAULT
		embed = Embed(title=embed_title, description=embed_description, 
						colour=embed_colour, timestamp=None)
		embed.add_field(name=f"{status.capitalize()} pieces", value=self.array_to_string(pieces_set), inline=False)
		
		await ctx.send(embed=embed)
		
	@piece.command(name="setother")
	async def set_unnassigned_pieces(self, ctx, status: Literal['owned', 'seeking', 'trade'], world_abbv: to_upper, 
		      map_name: Literal['1', '2', '3']):
		owner = ctx.author

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
		
		embed_description = None
		embed_colour = COLOUR_DEFAULT
		embed_fields = []

		pieces_unassigned_ids = db.column(PIECES_USER_UNNASSIGNED_QUERY, owner.id, map_id)
		
		if pieces_unassigned_ids:
			pieces_set = []
			for piece_id in pieces_unassigned_ids:
				db.execute("INSERT OR IGNORE INTO user_piece (id, piece_id, user_id, status, created_date) VALUES (?,?,?,?,?)", 
							str(uuid4()),
							piece_id,
							owner.id,
							status_value,
							datetime.utcnow())
				
				piece_name = db.field("SELECT name FROM piece WHERE id = ?", piece_id)
				pieces_set.append(piece_name)
				
			db.commit()
			
			embed_description = f"Marked all the unnassigned pieces for the map **{world_name} {map_name}** as **{status}** in your collection."
			embed_colour = COLOUR_SUCCESS
			embed_fields.append((
				f"{status.capitalize()} pieces", 
		       	f"{'None' if not pieces_set else self.array_to_string(pieces_set)}", 
			  	False
			))

		else:
			embed_description = f"There were no unnassigned pieces for the map **{world_name} {map_name}** in your collection."
			embed_colour = COLOUR_DEFAULT

		embed = Embed(title=world_name, description=embed_description, 
						colour=embed_colour, timestamp=None)
		for (name, value, inline) in embed_fields:
			embed.add_field(name=name, value=value, inline=inline)
		
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
		
		guild = ctx.message.guild
		
		map_name = piece_name[0]
		map_id = db.field("SELECT id FROM map WHERE name = ? AND world_id = ?", map_name, world_id)
		
		piece_id = db.field("SELECT id FROM piece WHERE map_id = ? AND name = ?", map_id, piece_name)
		if piece_id is None:
			await ctx.send(f'Bad argument: {piece_name}')
			raise BadArgument
		
		user_ids = db.column(PIECES_SEARCH_QUERY, world_id, piece_id, status_value)

		embed_title = f"Searching for {world_name} {piece_name} - **{status}**"
		embed_description = None
		embed_colour = COLOUR_DEFAULT
		embed_fields=[]

		if user_ids:
			user_names=[]
			for user_id in user_ids:
				try:
					user = guild.get_member(user_id)
					user_names.append(user.display_name)
				except Exception as exc:
					print(f"Caught exception at search {exc} - user_id: {user_id}")
					continue

			embed_description = self.plurals_results(len(user_names))
			
			embed_fields.append((
				f"{status.capitalize()}", 
				self.array_to_string(user_names), 
				False
			))
		
		else:
			embed_description = "No results found."

		embed = Embed(title=embed_title, description=embed_description, 
							colour=embed_colour, timestamp=None)
		
		for name, value, inline in embed_fields:
			embed.add_field(name=name, value=value, inline=inline)

		await ctx.send(embed=embed)
 
	@piece.command(name="seekingall")
	async def list_all_seeking(self, ctx):
		status_value = STATUS_SEEKING
		
		world_abbv_list = db.column("SELECT abbv FROM world")

		embed_fields=[]
		for world_abbv in world_abbv_list:
			(world_id, world_name) = db.record("SELECT id, name FROM world WHERE abbv = ?", world_abbv)
			pieces_seeking = db.column(PIECES_STATUS_ALL_USERS_QUERY, world_id, status_value)
			
			if pieces_seeking:
				embed_fields.append((world_name, self.array_to_string(pieces_seeking), False))

		embed_title = f"Seeking pieces"
		embed_description = None
		embed_colour = COLOUR_DEFAULT

		if embed_fields:
			embed_description = f"This is a list of all the pieces that at least one user is seeking."
		else:
			embed_description = "No results found."

		embed = Embed(title=embed_title, description=embed_description, 
							colour=embed_colour, timestamp=None)
		
		for name, value, inline in embed_fields:
			embed.add_field(name=name, value=value, inline=inline)

		await ctx.send(embed=embed)

	# # # # # # # #
	# Map commands

	@group(invoke_without_command=True)
	async def map(self, ctx):
		await ctx.send(f'Please specify the map command')

	@map.command(name="set")
	async def set_map_pieces(self, ctx, status: Literal['owned', 'seeking', 'trade', 'none', 'remove'], world_abbv: to_upper, 
		      map_name: Literal['1', '2', '3']):
		owner = ctx.author

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
		
		if status_value == STATUS_NONE:
			db.execute(MAP_REMOVE_ALL_PIECES_QUERY, owner.id, map_id)
			
			embed_description = f"Removed all the pieces for the map **{world_name} {map_name}** in your collection."
		
		else:
			piece_ids = db.column("SELECT id FROM piece WHERE map_id = ?", map_id)
			for piece_id in piece_ids:
				db.execute("INSERT OR IGNORE INTO user_piece (id, piece_id, user_id, status, created_date) VALUES (?,?,?,?,?)", 
							str(uuid4()),
							piece_id,
							owner.id,
							status_value,
							datetime.utcnow())
		
			embed_description = f"Marked all the pieces for the map **{world_name} {map_name}** as **{status}** in your collection."

		db.commit()
		
		embed = Embed(title=world_name, description=embed_description, 
						colour=COLOUR_SUCCESS, timestamp=None)
		
		await ctx.send(embed=embed)

	@map.command(name="complete")
	async def set_map_complete(self, ctx, world_abbv: to_upper, map_name: Literal['1', '2', '3']):
		owner = ctx.author
		
		(world_id, world_name) = db.record("SELECT id, name FROM world WHERE abbv = ?", world_abbv)
		if world_id is None or world_name is None:
			await ctx.send(f'Bad argument: {world_abbv}')
			raise BadArgument
		
		map_id = db.field("SELECT id FROM map WHERE name = ? AND world_id = ?", map_name, world_id)
		if map_id is None:
				await ctx.send(f'Bad argument: {map_name}')
				raise BadArgument
		
		db.execute(MAP_REMOVE_ALL_PIECES_STATUS_QUERY, owner.id, STATUS_OWNED, map_id)
		db.commit()

		embed_description = f"Set the map {world_name} {map_name} as completed and removed its pieces marked as **owned** in your collection."
		embed = Embed(title=world_name, description=embed_description, 
						colour=COLOUR_SUCCESS, timestamp=None)
		
		await ctx.send(embed=embed)

	@map.command(name="search")
	async def search_map(self, ctx, status: Literal['owned', 'seeking', 'trade'], world_abbv: to_upper, map_name: Optional[Literal['1', '2', '3']] = None):
		status_value = COMMAND_STATUS_MAPPING.get(status, None)
		if status_value is None:
			await ctx.send(f'Bad argument: {status}')
			raise BadArgument

		(world_id, world_name) = db.record("SELECT id, name FROM world WHERE abbv = ?", world_abbv)
		if world_id is None or world_name is None:
			await ctx.send(f'Bad argument: {world_abbv}')
			raise BadArgument
		
		guild = ctx.message.guild
		
		total_results = 0
		map_id_list = []
		if map_name:
			map_id = db.field("SELECT id FROM map WHERE name = ? AND world_id = ?", map_name, world_id)
			map_id_list.append(map_id)
		else:
			map_ids = db.column("SELECT id FROM map WHERE world_id = ?", world_id)
			map_id_list.extend(map_ids)

		print(map_id_list)

		embed_fields = []
		for map_id in map_id_list:
			map_name = db.field("SELECT name FROM map WHERE id = ?", map_id)
			field_title = f"{world_name} {map_name}"

			user_ids = db.column(MAP_SEARCH_QUERY, map_id, status_value)

			user_display_names = []
			for user_id in user_ids:
				try:
					member = guild.get_member(user_id)
					user_display_names.append(member.display_name)
				except Exception as exc:
					print(f"Caught exception at show_countdow {exc}")
					continue
			
			total_results += len(user_display_names)

			field_value = "None" if not user_display_names else self.array_to_string(user_display_names)

			embed_fields.append((field_title, field_value, False))


		embed_title = f"Searching for users on {world_name} - **{status}**"
		embed_description = None
		embed_colour = COLOUR_DEFAULT

		embed_description = self.plurals_results(total_results)

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