require_relative 'room'

class Castle
  attr_accessor :name, :rooms

  def initialize(name)
    @name = name
    @rooms = []
  end
end