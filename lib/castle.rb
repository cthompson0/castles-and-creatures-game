require_relative 'room'

class Castle
  attr_accessor :name, :rooms, :room_number

  def initialize(data)
    @name = data["name"]
    @room_number = 0
    @rooms = data["rooms"].map do |room|
      Room.new(room)
    end
  end

  def current_room
    @rooms[@room_number]
  end

  def progress_through_game_phases
    print_castle_progress
    current_room.room_phase
    current_room.monster_phase
  end

  def progress_to_next_room
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

  def print_castle_progress
    if @room_number == 0
      puts "You cautiously approach a #{@name} and venture inside."
    else
      puts "You continue searching the #{@name}."
    end
  end
end
