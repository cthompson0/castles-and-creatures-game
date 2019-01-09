# Castles and Creatures

### Getting Started

### Prerequisites

The game runs and builds itself with a supplied JSON file containing a series of castles, rooms, monsters and treasures. The supplied JSON file will need to be an array of hashes containing castle data adhering to the following format:

```
      "name": "Old Timey Medieval Castle",
      "rooms": [
        {
          "name": "dungeon",
          "monster": {
            "name": "skeleton warden",
            "win_chance": 95
          },
          "treasure": {
            "type": "jail cell key",
            "points": 10
          }
        },
        {
          "name": "the endless staircase",
          "monster": {
            "name": "cursed princess",
            "win_chance": 80
          },
          "treasure": {
            "type": "a ruby necklace",
            "points": 25
          }
        },
        {
          "name": "throne room",
          "monster": {
            "name": "the evil dragon",
            "win_chance": 70
          },
          "treasure": {
            "type": "the dragon's hoard",
            "points": 100
          }
        }
      ]
    }
```

### Installing

Once inside the game directory run:
> bundle install

In order to install all the necessary dependencies.

### Running tests
You can run the entire test suite from the root directory with
> rspec

Alternatively, you can run tests individually with
> rspec (file_spec.rb)

### Running the Game
By typing
> ruby lib/game.rb

The game should run successfully and require a file path to a JSON file (mentioned above) to build itself. A default game-layout.json will be provided to you.

### Rules of the Game

The player will progress sequentially through a series of castles and their rooms, fighting various monsters for the treasure they protect. 

The game is finished when the player has either collected all the treasure or has reached 0 lives.

Player moves:
> Fight - Allows the player to attempt to slay the monster at the cost of a life for failure.

> Bluff - Allows the player to attempt to scare the monster away. (Usable once per monster.)

> Treasure - Reveals current amassed treasure points.

> Lives - Reveals player lives left.

### Authors

- Chuck Thompson

### Acknowledgements

[Programming Practice - Cal Poly](http://users.csc.calpoly.edu/~jdalbey/103/Projects/ProgrammingPractice.html)