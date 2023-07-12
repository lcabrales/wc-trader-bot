from datetime import datetime

from apscheduler.schedulers.asyncio import AsyncIOScheduler
from discord import Intents
from discord import Embed
from discord.ext.commands import Bot as BotBase
from discord.ext.commands import CommandNotFound

from ..db import db


PREFIX = "$"
OWNER_IDS = [643110945274593281]
TOKEN_PATH = "./library/bot/token.txt"

class Bot(BotBase):
    def __init__(self):
        self.PREFIX = PREFIX
        self.guild = None
        self.scheduler = AsyncIOScheduler()
        self.ready = False

        db.autosave(self.scheduler)

        # intents = Intents.default()
        # intents.members = True
        # intents.message_content = True

        super().__init__(
            command_prefix=PREFIX, 
            owner_ids=OWNER_IDS, 
            intents=Intents.all()
        )
        
    def run(self, version):
        self.VERSION = version
        
        with open(TOKEN_PATH, "r", encoding="utf-8") as file:
            self.TOKEN = file.read()
            
        print("running bot...")
        super().run(self.TOKEN, reconnect=True)

    async def on_connect(self):
        print("bot connected: VERSION=" + self.VERSION)

    async def on_disconnect(self):
        print("bot disconnected")

    async def on_error(self, error, *args, **kwargs):
        if error == "on_command_error":
            channel = args[0]
            await channel.send("Something went wrong.")
            
        channel = self.get_channel(1128443141641482341)
        await channel.send("An error occurred.")

        raise

    async def on_command_error(self, context, exception):
        if isinstance(exception, CommandNotFound):
            pass
        elif hasattr(exception, "original"):
            raise exception.original
        else:
            raise exception

    async def on_ready(self):
        if not self.ready:
            self.ready = True
            self.guild = self.get_guild(1127307149161283655)
            self.scheduler.start()

            channel = self.get_channel(1128443141641482341)
            await channel.send("Now online!")

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
            
            print("bot ready")
            
        else:
            print("bot reconnected")

    async def on_message(self, message):
        pass
        
bot = Bot()