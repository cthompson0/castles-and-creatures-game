class Player
  attr_accessor :lives, :treasure, :move_list
  BLUFFING_CHANCE = 30
  DEFAULT_LIVES = 9
  DEFAULT_TREASURE = 0

  def initialize(lives=DEFAULT_LIVES, treasure=DEFAULT_TREASURE)
    @lives = lives
    @treasure = treasure
    @move_list = %w(Fight Bluff Treasure Lives)
  end

  def reset
    @lives = DEFAULT_LIVES
    @treasure = DEFAULT_TREASURE
  end

  def bluff_successful?
    rand(100) < BLUFFING_CHANCE
  end

  def add_treasure(treasure)
    @treasure += treasure
  end

  def lives_check
    puts "You currently have #{@lives} lives left."
  end

  def treasure_check
    puts "You currently have #{@treasure} points."
  end

  def remove_bluff
    @move_list.delete("Bluff")
  end

  def reset_move_list
    @move_list = %w(Fight Bluff Treasure Lives)
  end

  def move_text
    puts "*" * 25
    puts "What would you like to do?"
    puts @move_list
    puts "*" * 25
  end

  def game_over
    puts "Your score: #{@treasure}!"
    puts "GAME OVER!"
    puts "*" * 25
  end

  def game_over?
    @lives <= 0
  end
end