require 'rspec'
require 'rspec/core'
require 'json'
require_relative '../../castle.rb'
require_relative '../../room.rb'

describe Castle do
  before do
    file = File.read('../../game-layout.json')
    @castle_data = JSON.parse(file)
  end

  let(:castle) { Castle.new(@castle_data[0]) }

  it "initializes a castle with proper attributes" do
    expect(castle).to have_attributes(:name => "Old Timey Medieval Castle")
    expect(castle).to have_attributes(:room => 0)
    expect(castle.rooms[0]).to have_attributes(:name => "dungeon")
  end

  it "progresses through rooms of a castle" do
    castle.room_progression
    expect(castle.room).to eq(1)
  end

  it "resets the room progression back to zero" do
    castle.room_progression
    expect(castle.room).to eq(1)
    castle.room_reset
    expect(castle.room).to eq(0)
  end

  it "returns true when a castles rooms are all explored" do
    castle.room = castle.rooms.count - 1
    expect(castle.complete?).to eq(true)
  end

  it "gives the player the correct output when searching a castle" do
    expect { castle.castle_phase }.to output("You cautiously approach a Old Timey Medieval Castle and venture inside.\n").to_stdout
    castle.room = castle.rooms.count - 1
    expect { castle.castle_phase }.to output("You continue searching the Old Timey Medieval Castle.\n").to_stdout
  end
end