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


class Tracker(Cog):
	def __init__(self, bot):
		self.bot = bot

	def to_upper(argument):
		return argument.upper()
	
	@staticmethod
	def array_to_string(array):
		return ', '.join(array)

	@group(invoke_without_command=True)
	async def piece(self, ctx):
		await ctx.send(f'Please specify the piece command (add, remove, need, trade)')

	@piece.command(name="list")
	async def respond_list_command(self, ctx, status: Literal['owned', 'seeking', 'trade'], 
				world_abbv: to_upper, member: Optional[Member] = None):
				
		status_value = COMMAND_STATUS_MAPPING.get(status, None)
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
	async def set_piece(self, ctx, status: Literal['owned', 'seeking', 'trade', 'none'], world_abbv: to_upper, piece_name):
		status_value = COMMAND_STATUS_MAPPING.get(status, None)

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
		
		piece_exists = db.field("SELECT COUNT(*) FROM piece p INNER JOIN user_piece up ON p.id = up.piece_id WHERE p.id = ? AND up.user_id = ? AND status = ?", 
			  			piece_id, ctx.author.id, status_value) > 0

		embed_description = None
		embed_colour = COLOUR_DEFAULT
		if piece_exists:
			embed_description = f"You already marked the piece {piece_name} as {status}"
			embed_colour = COLOUR_ERROR

		else:
			db.execute("INSERT OR IGNORE INTO user_piece (id, piece_id, user_id, status, created_date) VALUES (?,?,?,?,?)", 
						str(uuid4()),
						piece_id,
						ctx.author.id,
						status_value,
						datetime.utcnow())
			
			embed_description = f"Marked the piece {piece_name} as {status} in your collection"
			embed_colour = COLOUR_SUCCESS

		embed = Embed(title=world_name, description=embed_description, 
						colour=embed_colour, timestamp=None)
		
		await ctx.send(embed=embed)

	@Cog.listener()
	async def on_ready(self):
		if not self.bot.ready:
			self.bot.cogs_ready.ready_up("tracker")


async def setup(bot):
	await bot.add_cog(Tracker(bot))
	

# class WorldDropdown(Select):
# 	def __init__(self):

# 		worlds = db.column("SELECT name FROM world")
# 		# Set the options that will be presented inside the dropdown
# 		options = []
# 		for world in worlds:
# 			options.append(SelectOption(label=world, description=None, emoji=None))

# 		# The placeholder is what will be shown when no option is chosen
# 		# The min and max values indicate we can only pick one of the three options
# 		# The options parameter defines the dropdown options. We defined this above
# 		super().__init__(placeholder='Select the world', min_values=1, max_values=1, options=options)

# 	async def callback(self, interaction: Interaction):
# 		# Use the interaction object to send a response message containing
# 		# the user's favourite colour or choice. The self object refers to the
# 		# Select object, and the values attribute gets a list of the user's
# 		# selected options. We only want the first one.
# 		view = MapPicker(self.values[0])

# 		# Sending a message containing our view
# 		await interaction.channel.send('Choose the piece to add to your collection:', view=view)

# class MapDropdown(Select):
# 	def __init__(self, selected_world):

# 		maps = db.column("SELECT name FROM map WHERE world_id=(SELECT id FROM world WHERE name = ?)", selected_world)
# 		# Set the options that will be presented inside the dropdown
# 		options = []
# 		for map in maps:
# 			options.append(SelectOption(label=map, description=None, emoji=None))

# 		# The placeholder is what will be shown when no option is chosen
# 		# The min and max values indicate we can only pick one of the three options
# 		# The options parameter defines the dropdown options. We defined this above
# 		super().__init__(placeholder='Select the map', min_values=1, max_values=1, options=options)

# 	async def callback(self, interaction: Interaction):
# 		# Use the interaction object to send a response message containing
# 		# the user's favourite colour or choice. The self object refers to the
# 		# Select object, and the values attribute gets a list of the user's
# 		# selected options. We only want the first one.
# 		await interaction.response.send_message(f'Your favourite colour is {self.values[0]}')
	

# class WorldPicker(View):
# 	def __init__(self):
# 		super().__init__()

# 		self.add_item(WorldDropdown())


# class MapPicker(View):
# 	def __init__(self, selected_world):
# 		super().__init__()

# 		self.add_item(MapDropdown(selected_world))