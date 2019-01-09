require 'json'
require_relative '../../lib/castle.rb'
require_relative '../../lib/room.rb'

describe Castle do
  let(:castle) { Castle.new({"name"=>"Old Timey Medieval Castle",
                             "rooms"=>[{
                                           "name"=>"dungeon",
                                           "monster"=>{"name"=>"skeleton warden", "win_chance"=>95},
                                           "treasure"=>{"type"=>"jail cell key", "points"=>10}},
                                       {"name"=>"the endless staircase",
                                        "monster"=>{"name"=>"cursed princess", "win_chance"=>80},
                                        "treasure"=>{"type"=>"a ruby necklace", "points"=>25}},
                                       {"name"=>"throne room",
                                        "monster"=>{"name"=>"the evil dragon", "win_chance"=>70},
                                        "treasure"=>{"type"=>"the dragon's hoard", "points"=>100}}]}) }
  let(:current_room) { castle.current_room }

  describe "#initialize" do
    it "initializes a castle with proper attributes" do
      expect(castle).to have_attributes(name: "Old Timey Medieval Castle")
      expect(castle).to have_attributes(room_number: 0)
      expect(castle.rooms[0]).to have_attributes(name: "dungeon")
    end
  end

  describe "#current_room" do
    it "returns the current room data within the castle" do
      expect(current_room.name).to eq("dungeon")
      expect(current_room.monster).to eq("skeleton warden")
      expect(current_room.win_chance).to eq(95)
      expect(current_room.points).to eq(10)
      expect(current_room.treasure).to eq("jail cell key")
    end
  end

  describe "#progress_to_next_room" do
    it "progresses through rooms of a castle" do
      castle.progress_to_next_room
      expect(castle.room_number).to eq(1)
    end
  end

  describe "#room_reset" do
    it "resets the room progression back to zero" do
      castle.progress_to_next_room
      expect(castle.room_number).to eq(1)
      castle.room_reset
      expect(castle.room_number).to eq(0)
    end
  end

  describe "#complete?" do
    it "returns true when a castles rooms are all explored" do
      castle.room_number = castle.rooms.count
      expect(castle.complete?).to eq(true)
    end
  end

  describe "#print_castle_progress" do
    it "gives the player the correct output when searching a castle" do
      expect { castle.print_castle_progress }.to output("You cautiously approach a Old Timey Medieval Castle and venture inside.\n").to_stdout
      castle.room_number += 1
      expect { castle.print_castle_progress }.to output("You continue searching the Old Timey Medieval Castle.\n").to_stdout
    end
  end
end
