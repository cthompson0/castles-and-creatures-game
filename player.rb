class Player
  attr_accessor :lives, :treasure

  def initialize(lives=9, treasure=0)
    @lives = lives
    @treasure = treasure
  end
end