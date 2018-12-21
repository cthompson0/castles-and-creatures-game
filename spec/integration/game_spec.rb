require 'rspec'
require 'rspec/core'
require_relative '../../lib/gamestate.rb'

describe Gamestate do
  let(:gamestate) { Gamestate.new(@castle_data) }

  context "winning conditions" do
    before do
      file = File.read('./spec/integration/config/game-layout-win.json')
      @castle_data = JSON.parse(file)
    end

    it "validates the player can win a game" do
      allow(STDIN).to receive(:gets).and_return("fight")
      expect(gamestate).to receive(:win)
      gamestate.play
    end
  end

  context "losing conditions" do
    before do
      file = File.read('./spec/integration/config/game-layout-lose.json')
      @castle_data = JSON.parse(file)
    end

    it "validates the player can lose a game" do
      allow(STDIN).to receive(:gets).and_return("fight")
      expect(gamestate).to receive(:ask_player_to_try_again)
      gamestate.play
    end
  end
end
