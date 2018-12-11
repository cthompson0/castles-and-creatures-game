class Room
  attr_accessor :name, :monster, :treasure, :win_chance, :treasure, :points

  def initialize(name, monster, win_chance, treasure, points)
    @name = name
    @monster = monster
    @win_chance = win_chance
    @treasure = treasure
    @points = points
  end
end