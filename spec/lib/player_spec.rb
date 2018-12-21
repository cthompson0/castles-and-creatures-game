require 'rspec'
require 'rspec/core'
require_relative '../../lib/gamestate.rb'
require_relative '../../lib/player.rb'

describe Player do
  let(:player) { Player.new }

  it "initializes the player with lives and treasure" do
    expect(player.lives).to eq(9)
    expect(player.treasure).to eq(0)
    expect(Player::BLUFFING_CHANCE).to eq(30)
  end

  it "resets the player values to default" do
    player.lives -= 1
    player.treasure += 100
    player.reset
    expect(player.lives).to eq(9)
    expect(player.treasure).to eq(0)
  end

  it "determines a successful bluff" do
    expect(player.bluff_successful?).to eq(true).or eq(false)
  end

  it "adds treasure to the player score" do
    expect{player.add_treasure(100)}.to change{player.treasure}.by(100)
  end

  it "outputs to the player the current lives left" do
    expect { player.lives_check }.to output("You currently have #{player.lives} lives left.\n").to_stdout
  end

  it "outputs to the player the treasure amount collected" do
    expect { player.treasure_check }.to output("You currently have #{player.treasure} points.\n").to_stdout
  end

  it "removes bluff from the player move list" do
    player.remove_bluff
    expect(player.move_list).to eq(%w(Fight Treasure Lives))
  end

  it "resets the player move list back to default" do
    player.remove_bluff
    expect(player.move_list).to eq(%w(Fight Treasure Lives))
    player.reset_move_list
    expect(player.move_list).to eq(%w(Fight Bluff Treasure Lives))
  end

  it "outputs the move phase text to the player" do
    expect(STDOUT).to receive(:puts).with("*" * 25).ordered
    expect(STDOUT).to receive(:puts).with("What would you like to do?").ordered
    expect(STDOUT).to receive(:puts).with(player.move_list).ordered
    expect(STDOUT).to receive(:puts).with("*" * 25).ordered
    player.move_text
  end

  it "outputs the game over text to the player" do
    expect(STDOUT).to receive(:puts).with("Your score: #{player.treasure}!").ordered
    expect(STDOUT).to receive(:puts).with("GAME OVER!").ordered
    expect(STDOUT).to receive(:puts).with("*" * 25).ordered
    player.game_over
  end

  it "determines a game over condition" do
    player.lives = 0
    expect(player.game_over?).to eq(true)
  end
end