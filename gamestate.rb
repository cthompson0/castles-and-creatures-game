require 'json'
require_relative 'player'
require_relative 'room'
require_relative 'castle'

class Gamestate

  def initialize(castle_data)
    @castle_data = castle_data
    @castles = []
    @castle_order = 0
    @player = Player.new
    @castle_data.each do |data|
      @castles << Castle.new(data)
    end
    play
  end

  def current_castle
    @castles[@castle_order]
  end

  def current_room
    current_castle.current_room
  end

  def next_castle_if_complete
    if current_castle.complete?
      @castle_order += 1
    end
  end

  def play
      current_castle.phasing
      player_move
    if @player.game_over?
      @player.game_over
      puts "Would you like to play again (Y/N)?"
      @play_again = gets.chomp.downcase
      case @play_again
      when "Y"
        reset
        play
      when "N"
        puts "Thanks for playing!"
      else
        puts "Please select Y or N to continue."
      end
    else
      play
    end
  end

  def player_move
    @player.move_text
    @selected_move = Kernel.gets.chomp

    case @selected_move.downcase
    when "fight"
      if current_room.fight_successful?
        current_room.monster_fight_win_text
        @player.reset_move_list
        @player.add_treasure(current_room.points)
        # if they_won_the_game
        unless win_condition?
          # change these method names
          current_castle.progress_to_next_room
          next_castle_if_complete
        end
      else
        @player.lives -= 1
        current_room.monster_fight_fail_text
        @player.lives_check
        unless @player.game_over?
          player_move
        end
      end
    when "bluff"
      if @player.move_list.include?("Bluff")
        if @player.bluff_successful?
          current_room.monster_bluff_win_text
          current_castle.progress_to_next_room
          next_castle_if_complete
        else
          current_room.monster_bluff_fail_text
          @player.move_list.delete("Bluff")
        end
      else
       puts "You tried that already!"
      end
    when "treasure"
      @player.treasure_check
    when "lives"
      @player.lives_check
    else
      puts "ERROR: Please select a valid action!"
      player_move
    end
  end

  def win_condition?
    @castles.count - 1 == @castle_order && current_castle.complete?
  end

  def win
    puts "You have successfully collected all the treasure!"
    reset
    play
  end

  def reset
    puts "*" * 25
    puts "Starting a new game.."
    puts "*" * 25
    @player.reset
    @castle_order = 0
    current_castle.room_reset
  end
end