require 'json'
require_relative 'player'
require_relative 'room'
require_relative 'castle'

# Game loop determines if player.lives = 0
# Should be aware of max pts possible to determine if all treasure found

# Integration tests: Player can win and player can lose
# Write more tests
# MAKE A DAMN README

# Player will not choose castle, castles will be sequential.

class GameState
  attr_accessor :player

  def initialize
    # User must provide this json file via CLI
    file = File.read('game-layout.json')
    @castle_data = JSON.parse(file)
    @player = Player.new

    @castles = []
    @castle_data.each_with_index do |castle, index|
      @castles << Castle.new(@castle_data[index]["name"])
    end

    
    @castle_data.each_with_index do |castle, index|
      @castle_data[index]["rooms"].each do |room|
          @castles[index].rooms << Room.new(room["name"],
                                            room["monster"]["name"],
                                            room["monster"]["win_chance"],
                                            room["treasure"]["type"],
                                            room["treasure"]["points"])
      end
    end

    @castles.each do |castle|
      puts castle.rooms[1].points
      puts "*"
    end
  end

  def play
    unless game_over
      move_phase
    else
      game_over
    end
  end

  def castle_select

    # Player will be given castles sequentially

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
    # Player will be given rooms sequentially after castle is given


    # @rooms = {}
    # @castle_data[@castle_mapping[@selected_castle]]["rooms"].each_with_index do |room, index|
    #   @rooms[room["name"]] = index
    # end
    #
    # @rooms.each do |room, v|
    #   puts room
    # end

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
    monster_encounter
  end

  def monster_encounter
    monster_name = @castle_data[@castle_mapping[@selected_castle]]["rooms"][@rooms[@selected_room]]["monster"]["name"]

    puts "*" * 25
    puts "You encounter a #{monster_name}!"
    puts "*" * 25
    monster_encounter_move
  end

  def monster_encounter_move
    fighting_chance = @castle_data[@castle_mapping[@selected_castle]]["rooms"][@rooms[@selected_room]]["monster"]["win_chance"] * 0.01
    bluffing_chance = 0.30

    puts "What would you like to do?"
    puts "Fight | Bluff"
    @selected_move = gets.chomp
    if @selected_room == "Fight"

    elsif @selected_room == "Bluff"
    else
      "ERROR: Please select a valid action!"
      monster_encounter_move
    end
  end

  def game_over
    @player.lives == 0
  end
end