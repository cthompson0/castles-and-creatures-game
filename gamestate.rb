require 'json'
require_relative 'player'
require_relative 'room'
require_relative 'castle'

class GameState
  attr_accessor :player

  def initialize
    load_file
    @castles = []
    @castle_order = 0
    @player = Player.new
    @move_list = %w(Fight Bluff Treasure Lives)
    @castle_data.each do |data|
      @castles << Castle.new(data)
    end
    @castle_data.each_with_index do |castle, index|
      castle["rooms"].each do |room|
        @castles[index].rooms << Room.new(room)
      end
    end
  end


  def play
    # Should this be here?
    unless game_over?
      # Could the classes handle this themselves?
      castle_progression
      room_progression
      monster_encounter
      player_move
      play
    else
      reset
      play
    end
  end

  def load_file
    puts "Please enter a filename or file path for castle data."
    game_layout = gets.chomp
    file = File.read(game_layout)
    @castle_data = JSON.parse(file)
  end

  def castle_progression
    if game_over?
      reset
      play
    elsif win_condition?
      puts "You have collected all the treasure!"
      puts "Your score is #{@player.treasure} points!"
      reset
      play
    else
      @current_castle = @castles[@castle_order].name 
      puts "You slowly approach a #{@current_castle} and venture inside."
    end
  end

  def room_progression
    @current_room = @castles[@castle_order].rooms[@castles[@castle_order].room].name
    puts "You come across a #{@current_room}."
  end

  def monster_encounter
    @current_monster = @castles[@castle_order].rooms[@castles[@castle_order].room].monster
    puts "#{@current_monster} jumps out in front of you!"
  end

  def player_move
    @fighting_chance = @castles[@castle_order].rooms[@castles[@castle_order].room].win_chance
    @current_treasure = @castles[@castle_order].rooms[@castles[@castle_order].room].treasure
    @treasure_points = @castles[@castle_order].rooms[@castles[@castle_order].room].points
    puts "*" * 25
    puts "What would you like to do?"
    puts @move_list
    puts "*" * 25
    @selected_move = gets.chomp

    case @selected_move.downcase
    when "fight"
      if fight_successful?
        puts "You successfully defeated the #{@current_monster}!"
        puts "You find a #{@current_treasure} clutched in a hand of the now lifeless #{@current_monster}."
        reset_move_list
        progress_game
      else
        @player.lives -= 1
        puts "The #{@current_monster} has defeated you."
        puts "You have #{@player.lives} lives left."
        puts "*" * 25
        player_move
      end
    when "bluff"
      if @move_list.include?("Bluff")
        if bluff_successful?
          puts "You successfully scare the #{@current_monster} and cause them to flee!"
          puts "You find a #{@current_treasure} on the floor where the #{@current_monster} was standing."
          progress_game
        else
          puts "Your attempts to scare #{@current_monster} have failed!"
          puts "Looks like you will have to fight your way out!"
          @move_list.delete("Bluff")
        end
      else
       puts "You tried that already!"
      end
    when "treasure"
      puts "You currently have #{@player.treasure} points."
    when "lives"
      puts "You currently have #{@player.lives} lives left."
    else
      puts "ERROR: Please select a valid action!"
      player_move
    end
  end

  def game_over?
    # debug statement goes here and check to see why this isnt working
    @player.lives <= 0
  end

  def win_condition?
    @castle_order == @castles.count && @castles[@castle_order].room == @castles[@castle_order].rooms.count
  end
  
  def fight_successful?
    rand(100) < @fighting_chance
  end

  def bluff_successful?
    rand(100) < Player::BLUFFING_CHANCE
  end

  def progress_game
    puts "You quickly put it into your pouch. (+#{@treasure_points} pts!)"
    @player.treasure += @treasure_points
    # Could this be if castle.complete?
      if @current_room != @castles[@castle_order].rooms.last.name
        @castles[@castle_order].room += 1
      else
        @castle_order += 1
        @castles[@castle_order].room = 0
      end
  end

  def reset
    puts "*" * 25
    puts "Your score: #{@player.treasure}!"
    puts "GAME OVER!"
    puts "Starting a new game.."
    puts "*" * 25
    @player.lives = 9
    @player.treasure = 0
    @castle_order = 0
    @castles[@castle_order].room = 0
  end

  def reset_move_list
    @move_list = %w(Fight Bluff Treasure Lives)
  end
end