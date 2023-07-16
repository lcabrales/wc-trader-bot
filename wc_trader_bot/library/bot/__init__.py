from asyncio import sleep
from datetime import datetime
from glob import glob

from apscheduler.schedulers.asyncio import AsyncIOScheduler
from discord import Intents
from discord import Embed, File, DMChannel
from discord.ext.commands import Bot as BotBase
from discord.ext.commands import Context
from discord.ext.commands import (CommandNotFound, BadArgument, MissingRequiredArgument,
								  CommandOnCooldown)
from discord.ext.commands import when_mentioned_or, command, has_permissions

from ..db import db

OWNER_IDS = [643110945274593281]
TOKEN_PATH = "./library/bot/token.txt"
PATH_SEPARATOR = "/" # change to "\\" for Windows
COGS = [path.split("/")[-1][:-3] for path in glob("./library/cogs/*.py")]
IGNORE_EXCEPTIONS = (CommandNotFound, BadArgument)
DEFAULT_PREFIX = "?"


def get_prefix(bot, message):
	prefix = DEFAULT_PREFIX

	if message.guild:
		prefix = db.field("SELECT bot_prefix FROM guild WHERE id = ?", message.guild.id)

	return when_mentioned_or(prefix)(bot, message)


class Ready(object):
	def __init__(self):
		for cog in COGS:
			setattr(self, cog, False)

	def ready_up(self, cog):
		setattr(self, cog, True)
		print(f" {cog} cog ready")

	def all_ready(self):
		return all([getattr(self, cog) for cog in COGS])


class Bot(BotBase):
	def __init__(self):
		self.guild = None
		self.scheduler = AsyncIOScheduler()

		self.ready = False
		self.cogs_ready = Ready()

		db.autosave(self.scheduler)

		try:
			with open("./data/banlist.txt", "r", encoding="utf-8") as f:
				self.banlist = [int(line.strip()) for line in f.readlines()]
		except FileNotFoundError:
			self.banlist = []

		super().__init__(
			command_prefix=get_prefix,
			owner_ids=OWNER_IDS, 
			intents=Intents.all(),
			help_command=None
        )

	async def setup_hook(self):
		for cog in COGS:
			await self.load_extension(f"library.cogs.{cog}")
			print(f"{cog} - cog loaded")

		print("setup complete")

	def update_db(self):
		db.multiexec("INSERT OR IGNORE INTO guild (id) VALUES (?)", 
					((guild.id,) for guild in self.guilds))
        
		db.commit()
        
	def run(self, version):
		self.VERSION = version
        
		with open(TOKEN_PATH, "r", encoding="utf-8") as file:
			self.TOKEN = file.read()
            
		print("running bot...")
		super().run(self.TOKEN, reconnect=True)
        
	async def process_commands(self, message):
		ctx = await self.get_context(message, cls=Context)

		if ctx.command is not None and ctx.guild is not None:
			if message.author.id in self.banlist:
				await ctx.send("You are banned from using commands.")

			elif not self.ready:
				await ctx.send("I'm not ready to receive commands. Please wait a few seconds.")

			else:
				await self.invoke(ctx)

	async def on_connect(self):
		print(f"bot connected: VERSION={self.VERSION}")

	async def on_disconnect(self):
		print("bot disconnected")

	async def on_error(self, error, *args, **kwargs):
		if error == "on_command_error":
			channel = args[0]
			await channel.send("Something went wrong.")
            
		await self.stdout_channel.send("An error occurred.")

		raise

	async def on_command_error(self, ctx, exception):
		if any([isinstance(exception, error) for error in IGNORE_EXCEPTIONS]):
			pass

		elif isinstance(exception, MissingRequiredArgument):
			await ctx.send("One or more required arguments are missing.")

		elif isinstance(exception, CommandOnCooldown):
			await ctx.send(f"That command is on {str(exception.cooldown.type).split('.')[-1]} cooldown. Try again in {exception.retry_after:,.2f} secs.")

		elif hasattr(exception, "original"):
			# if isinstance(exception.original, HTTPException):
			# 	await ctx.send("Unable to send message.")
			raise exception.original

		else:
			raise exception

	async def on_ready(self):
		if not self.ready:
			self.guild = self.get_guild(1127307149161283655)
			self.stdout_channel = self.get_channel(1128443141641482341)
			self.scheduler.start()

			self.update_db()
			
			while not self.cogs_ready.all_ready():
				await sleep(0.5)

			await self.stdout_channel.send("Now online!")
			self.ready = True
			print("bot ready")
			
		else:
			print("bot reconnected")

	async def on_message(self, message):
		if not message.author.bot:
			await self.process_commands(message)

bot = Bot()