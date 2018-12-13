class Room
  attr_accessor :name, :monster, :win_chance, :treasure, :points

  def initialize(data)
    @name = data["name"]
    @monster = data["monster"]["name"]
    @win_chance = data["monster"]["win_chance"]
    @treasure = data["treasure"]["type"]
    @points = data["treasure"]["points"]
  end
end