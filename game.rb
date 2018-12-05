require_relative 'gamestate'
require_relative 'player'

# RULES OF THE GAME

# World consists of Five castles
# Each castle contains 7 rooms
# Player has 9 lives
# Each room has a treasure worth a certain number of points
# A creature guards each treasure
# Treasure can be captured by bluffing or fighting the creature
# Bluffing has a 30% success rate
# Fighting difficulty varies for each creature.
# Losing a fight costs one life. No penalty for losing a bluff.
# Game ends when player has captured all treasure or has 0 lives.

# HOW IT WORKS

# Game program takes in a text / JSON file to build the castle / rooms
# Program must take in the text file and create a data structure to represent the world.
# HINT: Use a record structure for each room
# Game must handle player interaction returning, display of menus, room choices, lives and treasure pts.
# One character commands: fight, bluff, move

@new_game = GameState.new
@new_game.play