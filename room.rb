class Room
  attr_accessor :name, :monster, :win_chance, :treasure, :points

  def initialize(data)
    @name = data["name"]
    @monster = data["monster"]["name"]
    @win_chance = data["monster"]["win_chance"]
    @treasure = data["treasure"]["type"]
    @points = data["treasure"]["points"]
  end

  def room_phase
    puts "You come across a #{@name}."
  end

  def monster_phase
    puts "#{@monster} jumps out in front of you!"
  end
end