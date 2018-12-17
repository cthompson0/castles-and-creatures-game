require 'rspec'
require 'rspec/core'
require_relative '../../gamestate.rb'
require_relative '../../castle.rb'
require_relative '../../player.rb'

describe GameState do
  let(:gamestate) { GameState.new }
  let(:player) { Player.new }
  let(:input) { "../../game-layout.json\n" }

  before do
    allow(STDIN).to receive(:gets).and_return(input)
  end

  it "initializes the game with a JSON file and proper attributes" do
    gamestate.load_file
    expect(gamestate.instance_variable_get(:@castles)).not_to be_empty
    expect(gamestate.instance_variable_get(:@castle_order)).to eq(0)
    expect(gamestate.instance_variable_get(:@player)).to be_an_instance_of(Player)
    expect(gamestate.instance_variable_get(:@move_list)).to eq(["Fight", "Bluff", "Treasure", "Lives"])
  end
end