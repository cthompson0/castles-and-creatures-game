require_relative 'room'

class Castle
  attr_accessor :name, :rooms, :room

  def initialize(data)
    @name = data["name"]
    @rooms = []
    @room = 0
    data["rooms"].each do |room|
      @rooms << Room.new(room)
    end
  end

  def current_room
    @rooms[@room]
  end

  def phasing
    castle_phase
    current_room.room_phase
    current_room.monster_phase
  end

  def room_progression
    @room += 1
  end

  def room_reset
    @room = 0
  end

  def complete?
    @room == @rooms.count - 1
  end

  def castle_phase
    if @room == 0
      puts "You cautiously approach a #{@name} and venture inside."
    else
      puts "You continue searching the #{@name}."
    end
  end
end