require_relative '../../lib/game_interface.rb'

describe GameInterface do
  context "winning conditions" do
    it "validates the player can win a game" do
      allow(STDIN).to receive(:gets).and_return("./spec/integration/config/game-layout-win.json", "fight")
      expect{ GameInterface.play }.to output(/You have successfully collected all the treasure/).to_stdout
    end
  end

  context "losing conditions" do
    it "validates the player can lose a game" do
      allow(STDIN).to receive(:gets).and_return("./spec/integration/config/game-layout-lose.json", "fight")
      expect{ GameInterface.play }.to output(/You currently have 0 lives left./).to_stdout
    end
  end
end
