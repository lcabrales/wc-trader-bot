# This example requires the 'message_content' intent.

import discord
import logging
from discord.ext import commands

handler = logging.FileHandler(filename='discord.log', encoding='utf-8', mode='w')

# Defines a custom Select containing colour options
# that the user can choose. The callback function
# of this class is called when the user changes their choice
class Dropdown(discord.ui.Select):
    def __init__(self):

        # Set the options that will be presented inside the dropdown
        options = [
            discord.SelectOption(label='Red', description='Your favourite colour is red', emoji='🟥'),
            discord.SelectOption(label='Green', description='Your favourite colour is green', emoji='🟩'),
            discord.SelectOption(label='Blue', description='Your favourite colour is blue', emoji='🟦'),
        ]

        # The placeholder is what will be shown when no option is chosen
        # The min and max values indicate we can only pick one of the three options
        # The options parameter defines the dropdown options. We defined this above
        super().__init__(placeholder='Choose your favourite colour...', min_values=1, max_values=1, options=options)

    async def callback(self, interaction: discord.Interaction):
        # Use the interaction object to send a response message containing
        # the user's favourite colour or choice. The self object refers to the
        # Select object, and the values attribute gets a list of the user's
        # selected options. We only want the first one.
        await interaction.response.send_message(f'Your favourite colour is {self.values[0]}')


class DropdownView(discord.ui.View):
    def __init__(self):
        super().__init__()

        # Adds the dropdown to our view object.
        self.add_item(Dropdown())


class Bot(commands.Bot):
    def __init__(self):
        intents = discord.Intents.default()
        intents.message_content = True

        super().__init__(command_prefix=commands.when_mentioned_or('?'), intents=intents)

    async def on_ready(self):
        print(f'Logged in as {self.user} (ID: {self.user.id})')
        print('------')


bot = Bot()


@bot.command()
async def colour(ctx):
    """Sends a message with our dropdown containing colours"""

    # Create the view containing our dropdown
    view = DropdownView()

    # Sending a message containing our view
    await ctx.send('Pick your favourite colour:', view=view)


bot.run('MTEyNzMwNjkzOTUzNDE0NzcxNQ.GAi4Cr.d3CMIpCLs-SpKIIGoAIh2HvF-pSGkg0SHtIHXo', log_handler=handler, log_level=logging.DEBUG)


# intents = discord.Intents.default()
# intents.message_content = True

# client = discord.Client(intents=intents)

# @client.event
# async def on_ready():
#     print(f'We have logged in as {client.user}')

# @client.event
# async def on_message(message):
#     if message.author == client.user:
#         return

#     if message.content.startswith('$hello'):
#         await message.channel.send('Hello!')

# client.run('MTEyNzMwNjkzOTUzNDE0NzcxNQ.GAi4Cr.d3CMIpCLs-SpKIIGoAIh2HvF-pSGkg0SHtIHXo', log_handler=handler, log_level=logging.DEBUG)