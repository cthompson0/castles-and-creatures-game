require 'json'
require_relative 'player'

# Game loop determines if player.lives = 0
# Should be aware of max pts possible to determine if all treasure found
class GameState
  attr_accessor :player

  def initialize
    file = File.read('game-layout.json')
    @castle_data = JSON.parse(file)
    @player = Player.new
    # puts @castle_data[0]["rooms"][0]["monster"]["name"]
  end


  def play
    unless game_over
      move_phase
    else
      game_over
    end
  end

  def castle_select
    @castle_data.each do |castle|
      puts castle["name"]
    end
    puts "*" * 25
    puts "Please select a castle (0-4)"
    puts "*" * 25
    @selected_castle = gets.chomp.to_i
    if @selected_castle.between?(0,4)
      puts "You have selected #{@castle_data[@selected_castle]["name"]}"
    else
      puts "*" * 25
      puts "ERROR: Please select a castle within range!"
      puts "*" * 25
      castle_select
    end
  end

  def room_select
    @rooms = []
    @castle_data[@selected_castle]["rooms"].each do |room|
      @rooms << room["name"]
    end

    @rooms.each do |room|
      puts room
    end

    puts "*" * 25
    puts "Please select a room. (0-2)"
    puts "*" * 25
    @selected_room = gets.chomp
    if room_valid?
      puts "You have selected #{@selected_room}"
    else
      puts "Please select a valid room"
      room_select
    end
  end

  def room_valid?
    @rooms.include?(@selected_room)
  end

  def move_phase
    castle_select
    room_select
  end

  def monster_encounter

  end

  def game_over
    @player.lives == 0
  end
end