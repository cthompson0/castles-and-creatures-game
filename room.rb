class Room
  attr_accessor :name, :monster, :treasure

  def initialize(monster, treasure)
    @monster = monster
    @treasure = treasure
  end
end