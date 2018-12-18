require_relative 'gamestate'

class GameInterface

  def initialize
    castle_data = load_file
    Gamestate.new(castle_data)
  end

  def load_file
    puts "Please enter a filename or file path for castle data."
    game_layout = STDIN.gets.chomp
    file = File.read(game_layout)
    JSON.parse(file)
  end
end