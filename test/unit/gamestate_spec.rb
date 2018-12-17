require 'rspec'
require 'rspec/core'
require_relative '../../gamestate.rb'

describe GameState do
  let(:gamestate) { GameState.new }
  let(:input) { "../../game-layout.json\n" }

  it "initializes the game with JSON data after receiving input" do
    allow(STDIN).to receive(:gets).and_return(input)
    gamestate.load_file
  end
end