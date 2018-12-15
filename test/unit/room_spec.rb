require 'rspec'
require 'rspec/core'
require 'json'
require_relative '../../room.rb'

describe Room do
  before do
    file = File.read('../../game-layout.json')
    @castle_data = JSON.parse(file)
    @room_data = @castle_data[0]["rooms"][0]
  end

  let(:room) { Room.new(@room_data) }

  it "initializes a room with proper attributes" do
    expect(room).to have_attributes(:name => "dungeon")
    expect(room).to have_attributes(:monster => "skeleton warden")
    expect(room).to have_attributes(:win_chance => 95)
    expect(room).to have_attributes(:treasure => "jail cell key")
    expect(room).to have_attributes(:points => 10)
  end

  it "outputs to the player the correct room they are in" do
    expect { room.room_phase }.to output("You come across a dungeon.\n").to_stdout
  end

  it "outputs to the player the correct monster they are fighting" do
    expect { room.monster_phase }.to output("skeleton warden jumps out in front of you!\n").to_stdout
  end
end
