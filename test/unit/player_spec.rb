require 'rspec'
require 'rspec/core'
require 'json'
require_relative '../../gamestate.rb'
require_relative '../../player.rb'

describe Player do
  before do
    @player = Player.new
  end

  it "initializes the player with lives and treasure" do
    expect(@player.lives).to eq(9)
    expect(@player.treasure).to eq(0)
  end
end