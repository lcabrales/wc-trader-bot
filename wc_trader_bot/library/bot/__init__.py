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
COGS = [path.split("\\")[-1][:-3] for path in glob("./library/cogs/*.py")]
IGNORE_EXCEPTIONS = (CommandNotFound, BadArgument)


def get_prefix(bot, message):
	prefix = db.field("SELECT bot_prefix FROM guilds WHERE id = ?", message.guild.id)
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

		# intents = Intents.default()
		# intents.members = True
		# intents.message_content = True

		super().__init__(
			command_prefix=get_prefix, 
			owner_ids=OWNER_IDS, 
			intents=Intents.all()
        )

	def setup(self):
		for cog in COGS:
			self.load_extension(f"library.cogs.{cog}")
			print(f"{cog} - cog loaded")

		print("setup complete")

	def update_db(self):
		db.multiexec("INSERT OR IGNORE INTO guilds (id) VALUES (?)", 
					((guild.id,) for guild in self.guilds))
		db.multiexec("INSERT OR IGNORE INTO user (id) VALUES (?)", 
					((member.id,) for member in self.guild.members if not member.bot))

		to_remove = []
		stored_members = db.column("SELECT id FROM user")
		for id_ in stored_members:
			if not self.guild.get_member(id_):
				to_remove.append(id_)
                
		db.multiexec("DELETE FROM user WHERE id = ?", 
					((id_,) for id_ in to_remove))
        
		db.commit()
        
	def run(self, version):
		self.VERSION = version

		print("running setup...")
		self.setup()
        
		with open(TOKEN_PATH, "r", encoding="utf-8") as file:
			self.TOKEN = file.read()
            
		print("running bot...")
		super().run(self.TOKEN, reconnect=True)
        
	async def process_commands(self, message):
		context = await self.get_context(message, cls=Context)

		if context.command is not None and context.guild is not None:
			if message.author.id in self.banlist:
				await context.send("You are banned from using commands.")

			elif not self.ready:
				await context.send("I'm not ready to receive commands. Please wait a few seconds.")

			else:
				await self.invoke(context)

	async def on_connect(self):
		print("bot connected: VERSION=" + self.VERSION)

	async def on_disconnect(self):
		print("bot disconnected")

	async def on_error(self, error, *args, **kwargs):
		if error == "on_command_error":
			channel = args[0]
			await channel.send("Something went wrong.")
            
		await self.stdout_channel.send("An error occurred.")

		raise

	async def on_command_error(self, context, exception):
		if any([isinstance(exception, error) for error in IGNORE_EXCEPTIONS]):
			pass

		elif isinstance(exception, MissingRequiredArgument):
			await context.send("One or more required arguments are missing.")

		elif isinstance(exception, CommandOnCooldown):
			await context.send(f"That command is on {str(exception.cooldown.type).split('.')[-1]} cooldown. Try again in {exception.retry_after:,.2f} secs.")

		elif hasattr(exception, "original"):
			# if isinstance(exception.original, HTTPException):
			# 	await context.send("Unable to send message.")

			if isinstance(exception.original, exception):
				await context.send("I do not have permission to do that.")

			else:
				raise context.original

		else:
			raise exception

	async def on_ready(self):
		if not self.ready:
			self.guild = self.get_guild(1127307149161283655)
			self.stdout_channel = self.get_channel(1128443141641482341)
			self.scheduler.start()

			self.update_db()

			await self.stdout_channel.send("Now online!")

			# embed = Embed(title="Now online!", description="WC Trader Bot is now online.", 
			#               colour=0x0058F2, timestamp=datetime.utcnow())
			# fields = [
			#     ("Name", "Value", True),
			#     ("Name 2", "Value 2", True),
			#     ("Name 3", "Value 3", False),
			# ]
			# for name, value, inline in fields:
			#     embed.add_field(name=name, value=value, inline=inline)

			# icon_url = None
			# if (icon_url := self.guild.icon) is not None: icon_url = self.guild.icon.url
			# embed.set_author(name="World Challenges Bot", icon_url=icon_url)
			# embed.set_thumbnail(url=icon_url)
			# embed.set_image(url=icon_url)
			# embed.set_footer(text="Footer")

			# await channel.send(embed=embed)
			
			while not self.cogs_ready.all_ready():
				await sleep(0.5)

			await self.stdout.send("Now online!")
			self.ready = True
			print("bot ready")

			meta = self.get_cog("Meta")
			await meta.set()
			
		else:
			print("bot reconnected")

	async def on_message(self, message):
		if not message.author.bot:
			if isinstance(message.channel, DMChannel):
				if len(message.content) < 50:
					await message.channel.send("Your message should be at least 50 characters in length.")

				else:
					member = self.guild.get_member(message.author.id)
					embed = Embed(title="Modmail",
								  colour=member.colour,
								  timestamp=datetime.utcnow())

					embed.set_thumbnail(url=member.avatar_url)

					fields = [("Member", member.display_name, False),
							  ("Message", message.content, False)]

					for name, value, inline in fields:
						embed.add_field(name=name, value=value, inline=inline)
					
					mod = self.get_cog("Mod")
					await mod.log_channel.send(embed=embed)
					await message.channel.send("Message relayed to moderators.")

			else:
				await self.process_commands(message)
		
bot = Bot()