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

    @castle_mapping = { }
    @castle_data.each_with_index do |name, index|
      @castle_mapping[@castle_data[index]["name"]] = index
    end

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
    @castles = []
    @castle_data.each do |castle|
      @castles << castle["name"]
    end

    @castles.each do |castle|
      puts castle
    end

    puts "*" * 25
    puts "Please select a castle."
    puts "*" * 25
    @selected_castle = gets.chomp
    if castle_valid?
      puts "You have selected #{@selected_castle}"
    else
      puts "*" * 25
      puts "ERROR: Please select a valid castle!"
      puts "*" * 25
      castle_select
    end
  end

  def room_select
    @rooms = []
    @castle_data[@castle_mapping[@selected_castle]]["rooms"].each do |room|
      @rooms << room["name"]
    end

    @rooms.each do |room|
      puts room
    end

    puts "*" * 25
    puts "Please select a room."
    puts "*" * 25
    @selected_room = gets.chomp
    if room_valid?
      puts "You have selected #{@selected_room}"
    else
      puts "*" * 25
      puts "ERROR: Please select a valid room!"
      puts "*" * 25
      room_select
    end
  end

  def castle_valid?
    @castles.include?(@selected_castle)
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