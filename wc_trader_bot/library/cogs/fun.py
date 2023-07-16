from random import choice, randint
from typing import Optional

from aiohttp import request
from discord import Member, Embed
from discord.ext.commands import Cog
from discord.ext.commands import BadArgument, BucketType
from discord.ext.commands import command, cooldown


class Fun(Cog):
	def __init__(self, bot):
		self.bot = bot

	@command(name="hello", aliases=["hi"])
	async def say_hello(self, ctx):
		await ctx.send(f"{choice(('Hello', 'Hi', 'Hey', 'Hiya'))} {ctx.author.mention}!")

	@command(name="coinflip", aliases=["coin"])
	async def coinflip(self, ctx):
		await ctx.send(f"{choice(('Heads', 'Tails'))}")

	@Cog.listener()
	async def on_ready(self):
		if not self.bot.ready:
			self.bot.cogs_ready.ready_up("fun")


async def setup(bot):
	await bot.add_cog(Fun(bot))