from datetime import datetime, timedelta
from platform import python_version
from time import time

from apscheduler.triggers.cron import CronTrigger
from discord import Activity, ActivityType, Embed
from discord import __version__ as discord_version
from discord.ext.commands import Cog
from discord.ext.commands import CheckFailure
from discord.ext.commands import command, is_owner
from psutil import Process, virtual_memory


class Meta(Cog):
	def __init__(self, bot):
		self.bot = bot

		# self._message = "watching +help | {users:,} users in {guilds:,} servers"

		# bot.scheduler.add_job(self.set, CronTrigger(second=0))

	@property
	def message(self):
		return self._message.format(users=len(self.bot.users), guilds=len(self.bot.guilds))

	@message.setter
	def message(self, value):
		if value.split(" ")[0] not in ("playing", "watching", "listening", "streaming"):
			raise ValueError("Invalid activity type.")

		self._message = value

	async def set(self):
		_type, _name = self.message.split(" ", maxsplit=1)

		await self.bot.change_presence(activity=Activity(
			name=_name, type=getattr(ActivityType, _type, ActivityType.playing)
		))

	@command(name="setactivity")
	@is_owner()
	async def set_activity_message(self, ctx, *, text: str):
		self.message = text
		await self.set()
	
	@set_activity_message.error
	async def set_activity_message_error(self, ctx, exc):
		if isinstance(exc, CheckFailure):
			await ctx.send("Command reserved for the bot owner.")

	@command(name="ping")
	@is_owner()
	async def ping(self, ctx):
		start = time()
		message = await ctx.send(f"Pong! DWSP latency: {self.bot.latency*1000:,.0f} ms.")
		end = time()

		await message.edit(content=f"Pong! DWSP latency: {self.bot.latency*1000:,.0f} ms. Response time: {(end-start)*1000:,.0f} ms.")

	@ping.error
	async def ping_error(self, ctx, exc):
		if isinstance(exc, CheckFailure):
			await ctx.send("Command reserved for the bot owner.")

	@command(name="stats")
	@is_owner()
	async def show_bot_stats(self, ctx):
		embed = Embed(title="Bot stats",
					  colour=ctx.author.colour,
					  timestamp=datetime.utcnow())

		proc = Process()
		with proc.oneshot():
			uptime = timedelta(seconds=time()-proc.create_time())
			cpu_time = timedelta(seconds=(cpu := proc.cpu_times()).system + cpu.user)
			mem_total = virtual_memory().total / (1024**2)
			mem_of_total = proc.memory_percent()
			mem_usage = mem_total * (mem_of_total / 100)

		fields = [
			("Bot version", self.bot.VERSION, True),
			("Python version", python_version(), True),
			("discord.py version", discord_version, True),
			("Uptime", uptime, True),
			("CPU time", cpu_time, True),
			("Memory usage", f"{mem_usage:,.3f} / {mem_total:,.0f} MiB ({mem_of_total:.0f}%)", True),
			# ("Users", f"{self.bot.guild.member_count:,}", True)
		]

		for name, value, inline in fields:
			embed.add_field(name=name, value=value, inline=inline)

		await ctx.send(embed=embed)
		
	@show_bot_stats.error
	async def show_bot_stats_error(self, ctx, exc):
		if isinstance(exc, CheckFailure):
			await ctx.send("Command reserved for the bot owner.")

	@Cog.listener()
	async def on_ready(self):
		if not self.bot.ready:
			self.bot.cogs_ready.ready_up("meta")


async def setup(bot):
	await bot.add_cog(Meta(bot))