require_relative 'gamestate'

class GameInterface

  def self.play
    castle_data = castle_layout
    game = Gamestate.new(castle_data)
    game.play
  end

  def self.castle_layout
    puts "Please enter a filename or file path for castle data."
    game_layout = STDIN.gets.chomp
    file = File.read(game_layout)
    JSON.parse(file)
  end
end
