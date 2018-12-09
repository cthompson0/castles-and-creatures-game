require 'json'
require_relative 'room'

class Castle
  attr_accessor :name, :rooms

  def initialize(name)
    @name = name
    @rooms = rooms

    # @castle_data.each_with_index do |name, index|
    #   @castles << @castle_data[index]["name"]
    # end
    #
    # @castle_mapping = { }
    # @castle_data.each_with_index do |name, index|
    #   @castle_mapping[@castle_data[index]["name"]] = index
    # end
    #
    # puts @castles
  end

end