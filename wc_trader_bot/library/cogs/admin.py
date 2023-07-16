from random import choice, randint
from typing import Optional

from aiohttp import request
from discord import Member, Embed
from discord.ext.commands import Cog
from discord.ext.commands import BadArgument, BucketType, CheckFailure
from discord.ext.commands import command, has_permissions

from ..db import db

class Admin(Cog):
	def __init__(self, bot):
		self.bot = bot

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

	@Cog.listener()
	async def on_ready(self):
		if not self.bot.ready:
			self.bot.cogs_ready.ready_up("admin")


async def setup(bot):
	await bot.add_cog(Admin(bot))