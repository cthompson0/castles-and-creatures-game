require 'rspec'
require 'rspec/core'
require_relative '../../gamestate.rb'

describe Gamestate do
  let(:gamestate) { Gamestate.new }
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

  it "accepts a chosen player move until game over" do
    allow(Kernel).to receive(:gets).and_return("fight")
    # allow(Kernel).to receive(:play_again).and_return("n")
    gamestate.play
  end

  it "sequences the game phases in proper order" do

  end

  it "evaluates a game over properly" do
    allow(Kernel).to receive(:gets).and_return("fight")
    allow(Kernel).to receive(:play_again).and_return("n")
    gamestate.play
    expect(gamestate.game_over?).to eq(true)
  end

  # Use a fixture for this test
  it "evaluates a winning condition properly" do

  end

  # Not passing. Need to manipulate the variables at play.
  it "determines a successful fight" do
    @attempt = 94
    @fighting_chance = 95
    expect(gamestate.fight_successful?).to eq(true)
  end

  # Same idea as above.
  it "determines a successful bluff" do

  end

  it "progresses the game after a successful fight or bluff" do

  end

  it "outputs game over text to player" do
    # I dont want this line here.. but I have to.
    expect(STDOUT).to receive(:puts).with("Please enter a filename or file path for castle data.").ordered
    expect(STDOUT).to receive(:puts).with("Your score: 0!").ordered
    expect(STDOUT).to receive(:puts).with("GAME OVER!").ordered
    expect(STDOUT).to receive(:puts).with("*************************").ordered
    gamestate.game_over
  end

  it "resets the game to starting values" do

  end

  it "resets the move list back to full list" do

  end
end
