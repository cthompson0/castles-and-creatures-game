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
    @castles = []
    @castle_order = 0
    @room_order = 0
    @player = Player.new
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
  end

  def play
    unless game_over
      move_phase
    else
      game_over
    end
  end

  def castle_select
    @current_castle = @castles[@castle_order].name
    puts "You slowly approach a #{@current_castle} and venture inside."
  end

  def room_select
    @current_room = @castles[@castle_order].rooms[@room_order].name
    puts "After entering the #{@castles[@castle_order].name}, you come across a #{@current_room}."
  end

  def move_phase
    castle_select
    room_select
    monster_encounter
    player_move
    move_phase
  end

  def monster_encounter
    @current_monster = @castles[@castle_order].rooms[@room_order].monster
    puts "While exploring the #{@current_room}, a #{@current_monster} jumps out in front of you!"
  end

  def player_move
    fighting_chance = @castles[@castle_order].rooms[@room_order].win_chance
    bluffing_chance = 30
    current_treasure = @castles[@castle_order].rooms[@room_order].treasure
    treasure_points = @castles[@castle_order].rooms[@room_order].points

    puts "*" * 25
    puts "What would you like to do?"
    puts "Fight | Bluff"
    puts "*" * 25
    @selected_move = gets.chomp
    if @selected_move == "Fight"
      if rand(100) < fighting_chance
        puts "You successfully defeated the #{@current_monster}!"
        puts "You find a #{current_treasure} clutched in a hand of the now lifeless #{@current_monster}."
        puts "You quickly put it into your pouch. (+#{treasure_points} pts!)"
      else
        puts "The #{@current_monster} has defeated you."
        puts "You have #{@player.lives} lives left."
        puts "*" * 25
        @player.lives -= 1
      end

    elsif @selected_move == "Bluff"
      if rand(100) < bluffing_chance
        puts "You successfully scare the #{@current_monster} and cause them to flee!"
        puts "You find a #{current_treasure} on the floor where the #{@current_monster} was standing."
        puts "You quickly put it into your pouch. (+#{treasure_points} pts!)"
      else
        puts "Your attempts to scare the #{@current_monster} have failed!"
        puts "Looks like you will have to fight your way out!"
        end
    else
      "ERROR: Please select a valid action!"
      player_move
    end
  end

  def game_over
    @player.lives == 0
  end
end