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
  end

  def current_castle
    @castles[@castle_order]
  end

  def current_room
    current_castle.current_room
  end

  def next_castle_if_complete
    if current_castle.complete? && @castle_order < @castles.count - 1
      @castle_order += 1
    end
  end

  def play
    current_castle.phasing
    player_move
    if @player.dead?
      @player.game_over_report
      ask_player_to_try_again
    elsif win_condition?
      win
    else
      play
    end
  end

  def ask_player_to_try_again
    puts "Would you like to play again (Y/N)?"
    play_again = STDIN.gets.chomp.downcase
    if play_again == "y"
      reset
      play
    elsif play_again == "n"
      puts "Thanks for playing!"
      exit
    else
      "Please select Y or N to continue."
    end
  end

  def player_move
    @player.move_text
    @selected_move = STDIN.gets.chomp

    case @selected_move.downcase
    when "fight"
      if current_room.fight_successful?
        current_room.monster_fight_win_text
        @player.reset_move_list
        @player.add_treasure(current_room.points)
          current_castle.progress_to_next_room
          next_castle_if_complete
      else
        @player.lives -= 1
        current_room.monster_fight_fail_text
        @player.lives_check
        unless @player.dead?
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
    @castles.count - 1 == @castle_order && current_castle.rooms.count == current_castle.room_number
  end

  def win
    puts "You have successfully collected all the treasure!"
    @player.game_over_report
    ask_player_to_try_again
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