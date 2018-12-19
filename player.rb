class Player
  attr_accessor :lives, :treasure
  BLUFFING_CHANCE = 30
  DEFAULT_LIVES = 9
  DEFAULT_TREASURE = 0

  def initialize(lives=DEFAULT_LIVES, treasure=DEFAULT_TREASURE)
    @lives = lives
    @treasure = treasure
  end

  def reset
    @lives = DEFAULT_LIVES
    @treasure = DEFAULT_TREASURE
  end

  def bluff_successful?
    rand(100) < BLUFFING_CHANCE
  end

  def fight_successful?(chance)
    rand(100) < chance
  end

  def add_treasure(treasure)
    @treasure += treasure
  end

  def lives_check
    puts "You currently have #{@lives} lives left."
  end

  def treasure_check
    puts "You currently have #{@player.treasure} points."
  end
end