class Player
  attr_accessor :lives, :treasure, :move_list
  BLUFFING_CHANCE = 30
  DEFAULT_LIVES = 9
  DEFAULT_TREASURE = 0

  def initialize
    self.lives = DEFAULT_LIVES
    self.treasure = DEFAULT_TREASURE
    self.move_list = %w(Fight Bluff Treasure Lives)
  end

  def reset
    self.lives = DEFAULT_LIVES
    self.treasure = DEFAULT_TREASURE
  end

  def bluff_successful?
    rand(100) < BLUFFING_CHANCE
  end

  def add_treasure(treasure)
    self.treasure += treasure
  end

  def lives_check
    puts "You currently have #{self.lives} lives left."
  end

  def treasure_check
    puts "You currently have #{self.treasure} points."
  end

  def remove_bluff
    self.move_list.delete("Bluff")
  end

  def reset_move_list
    self.move_list = %w(Fight Bluff Treasure Lives)
  end

  def move_text
    puts "*" * 25
    puts "What would you like to do?"
    puts self.move_list
    puts "*" * 25
  end

  def game_over_report
    puts "Your score: #{@treasure}!"
    puts "GAME OVER!"
    puts "*" * 25
  end

  def dead?
    self.lives <= 0
  end
end
