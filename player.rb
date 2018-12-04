require_relative 'gamestate'

# Attaches attributes to a player object. Tracks lives and treasure.
# Controls player actions: fight, bluff, move

class Player
  attr_accessor :lives, :treasure

  def initialize(lives=9, treasure=0)
    @lives = lives
    @treasure = treasure
  end
end