require 'rspec'
require 'rspec/core'
require 'json'
require_relative 'gamestate'
require_relative 'castle'
require_relative 'player'
require_relative 'room'

describe GameState do
  before :each do
    @player = Player.new
    @castle = Castle.new("Hogwarts")
    @room = Room.new("Closet", "Ogre", 95, "Golden Snitch", 100)

    file = File.read('game-layout.json')
    @castle_data = JSON.parse(file)
    @castles = []
    @castle_data.each_with_index do |castle, index|
      @castles << Castle.new(@castle_data[index]["name"])
    end

    @castle_data.each_with_index do |castle, index|
      @castle_data[index]["rooms"].each do |room|
        @castles[index].rooms << Room.new(room["name"],
                                          room["monster"]["name"],
                                          room["monster"]["win_chance"],
                                          room["treasure"]["type"],
                                          room["treasure"]["points"])

      end
    end
  end

  it "initializes the player with lives and treasure" do
    expect(@player.lives).to eq(9)
    expect(@player.treasure).to eq(0)
  end

  it "initializes a castle with proper attributes" do
    expect(@castle).to have_attributes(:name => "Hogwarts")
    expect(@castle).to have_attributes(:rooms => [])
  end

  it "initializes a room with proper attributes" do
    expect(@room).to have_attributes(:name => "Closet")
    expect(@room).to have_attributes(:monster => "Ogre")
    expect(@room).to have_attributes(:win_chance => 95)
    expect(@room).to have_attributes(:treasure => "Golden Snitch")
    expect(@room).to have_attributes(:points => 100)
  end

  it "initializes the game with the appropriate amount of castles" do
    expect(@castle_data.count).to eq(5)
  end

  it "initializes the game with the appropriate amount of rooms" do
    expect(@castles[0].rooms.count).to eq(3)
  end
end