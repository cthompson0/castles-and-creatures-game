require 'rspec'
require 'rspec/core'
require_relative 'game'


describe Player do
  before :each do
    @player = Player.new
  end

  it "initializes the player with lives and treasure" do
    expect(@player.lives).to eq(9)
    expect(@player.treasure).to eq(0)
  end
end



