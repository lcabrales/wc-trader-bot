from discord.ext.commands import Cog
from discord.ext.commands import command


HELP_README_URL = "https://gist.github.com/panacea0706/62ce539ea6d5e2b0a2ce606cd8315f25"


class Help(Cog):
	def __init__(self, bot):
		self.bot = bot

	@command(name="help")
	async def show_readme_url(self, ctx):
		await ctx.send(HELP_README_URL)

	@Cog.listener()
	async def on_ready(self):
		if not self.bot.ready:
			self.bot.cogs_ready.ready_up("help")


async def setup(bot):
	await bot.add_cog(Help(bot))