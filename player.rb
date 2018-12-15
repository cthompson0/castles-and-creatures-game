class Player
  attr_accessor :lives, :treasure
  BLUFFING_CHANCE = 30

  def initialize(lives=9, treasure=0)
    @lives = lives
    @treasure = treasure
  end

  def reset
    @lives = 9
    @treasure = 0
  end
end