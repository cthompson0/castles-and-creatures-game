require 'rspec'
require 'rspec/core'
require_relative '../../gamestate.rb'
require_relative '../../player.rb'

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
end