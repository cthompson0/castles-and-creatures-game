require 'json'
require_relative '../../lib/room.rb'

describe Room do
  let(:room_data) do {
      "name"=>"dungeon",
      "monster"=>{"name"=>"skeleton warden", "win_chance"=>95},
      "treasure"=>{"type"=>"jail cell key", "points"=>10} }
  end

  let(:room) { Room.new(room_data) }

  describe "#initialize" do
    it "initializes a room with proper attributes" do
      expect(room).to have_attributes(name: "dungeon")
      expect(room).to have_attributes(monster: "skeleton warden")
      expect(room).to have_attributes(win_chance: 95)
      expect(room).to have_attributes(treasure: "jail cell key")
      expect(room).to have_attributes(points: 10)
    end
  end

  describe "#room_phase" do
    it "outputs to the player the correct room they are in" do
      expect { room.room_phase }.to output("You come across a dungeon.\n").to_stdout
    end
  end

  describe "#monster_phase" do
    it "outputs to the player the correct monster they are fighting" do
      expect { room.monster_phase }.to output("skeleton warden jumps out in front of you!\n").to_stdout
    end
  end
end
