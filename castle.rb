require_relative 'room'

class Castle
  attr_accessor :name, :rooms, :room

  def initialize(data, rooms = [])
    @name = data["name"]
    @rooms = rooms
    # Think about renaming this to room_number
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

  def progress
    puts "You quickly put it into your pouch. (+#{current_room.points} pts!)"
    if complete?
      room_reset
    else
      next_room
    end
  end

  def next_room
    @room += 1
  end

  def room_reset
    @room = 0
  end

  def complete?
    @room == @rooms.count
  end

  def castle_phase
    if @room == 0
      puts "You cautiously approach a #{@name} and venture inside."
    else
      puts "You continue searching the #{@name}."
    end
  end
end