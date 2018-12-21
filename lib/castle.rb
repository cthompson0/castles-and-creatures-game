require_relative 'room'

class Castle
  attr_accessor :name, :rooms, :room_number

  def initialize(data, rooms = [])
    @name = data["name"]
    @rooms = rooms
    @room_number = 0
    data["rooms"].each do |room|
      @rooms << Room.new(room)
    end
  end

  def current_room
    @rooms[@room_number]
  end

  def phasing
    castle_phase
    current_room.room_phase
    current_room.monster_phase
  end

  def progress_to_next_room
    puts "You quickly put it into your pouch. (+#{current_room.points} pts!)"
    if complete?
      room_reset
    else
      next_room
    end
  end

  def next_room
    @room_number += 1
  end

  def room_reset
    @room_number = 0
  end

  def complete?
    @room_number == @rooms.count
  end

  def castle_phase
    if @room_number == 0
      puts "You cautiously approach a #{@name} and venture inside."
    else
      puts "You continue searching the #{@name}."
    end
  end
end