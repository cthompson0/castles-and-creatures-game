require 'rspec'
require 'rspec/core'
require_relative '../../lib/gamestate.rb'

describe Gamestate do
  let(:castle_data) do [{"name"=>"Old Timey Medieval Castle",
                         "rooms"=>[{
                                   "name"=>"dungeon",
                                       "monster"=>{"name"=>"skeleton warden", "win_chance"=>95},
                                       "treasure"=>{"type"=>"jail cell key", "points"=>10}},
                                   {"name"=>"the endless staircase",
                                      "monster"=>{"name"=>"cursed princess", "win_chance"=>80},
                                      "treasure"=>{"type"=>"a ruby necklace", "points"=>25}},
                                   {"name"=>"throne room",
                                      "monster"=>{"name"=>"the evil dragon", "win_chance"=>70},
                                      "treasure"=>{"type"=>"the dragon's hoard", "points"=>100}}]}]
  end
  let(:gamestate) { Gamestate.new(castle_data) }

  it "initializes the game with a JSON file and proper attributes" do
    expect(gamestate.instance_variable_get(:@castle_order)).to eq(0)
    expect(gamestate.instance_variable_get(:@castles)).to_not be_nil
  end

  it "keeps track of and returns the current castle data" do
    expect(gamestate.current_castle).to_not be_nil
    expect(gamestate.current_castle.name).to eq("Old Timey Medieval Castle")
  end

  it "keeps track of data for current room of current castle" do
    expect(gamestate.current_room).to_not be_nil
    expect(gamestate.current_room.name).to eq("dungeon")
  end

  it "validates the player can try again on game over" do
    expect(STDOUT).to receive(:puts).with("Would you like to play again (Y/N)?")
    allow(STDIN).to receive(:gets).and_return("Y")
    expect(gamestate).to receive(:reset)
    expect(gamestate).to receive(:play)
    gamestate.ask_player_to_try_again
  end

  it "validates the player can decline a try again on game over" do
    expect(STDOUT).to receive(:puts).with("Would you like to play again (Y/N)?")
    allow(STDIN).to receive(:gets).and_return("N")
    expect(STDOUT).to receive(:puts).with("Thanks for playing!")
    gamestate.ask_player_to_try_again
  end

  it "resets the game and game data accurately" do
    expect(STDOUT).to receive(:puts).with("*" * 25)
    expect(STDOUT).to receive(:puts).with("Starting a new game..")
    expect(STDOUT).to receive(:puts).with("*" * 25)
    expect(gamestate.instance_variable_get(:@castle_order)).to eq(0)
    gamestate.reset
  end
end