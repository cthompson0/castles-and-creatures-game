require_relative '../../lib/gamestate.rb'

describe Gamestate do
  let(:game) { Gamestate.new(@castle_data) }

  before do
    @castle_data = JSON.parse(file)
  end

  context "winning conditions" do
    let(:file) { File.read('./spec/integration/config/game-layout-win.json') }

    it "validates the player can win a game" do
      allow(STDIN).to receive(:gets).and_return("fight")
      expect(game).to receive(:win)
      expect(game).to receive(:ask_player_to_try_again)
      game.play
    end
  end

  context "losing conditions" do
    let(:file) { File.read('./spec/integration/config/game-layout-lose.json') }

    it "validates the player can lose a game" do
      allow(STDIN).to receive(:gets).and_return("fight")
      expect(game).to receive(:ask_player_to_try_again)
      game.play
    end
  end
end
