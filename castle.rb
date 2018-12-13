require_relative 'room'

class Castle
  attr_accessor :name, :rooms, :room

  def initialize(data)
    @name = data["name"]
    @rooms = []
    @room = 0
  end

  def castle_complete?
    # Castle rooms.length = @room
  end
end