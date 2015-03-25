require 'player'

describe Player do

  let(:test_player1) {Player.new}
  let(:test_player2) {Player.new}
  let(:test_cards) {[Card.new(:hearts, :eight), Card.new(:clubs, :jack)]}

  describe '#initalize' do
    it "should initalize the players pot to the base value" do
      expect(test_player1.pot).to eql(Player::BASE_POT)
    end

    it "should start the player with no cards" do
      puts test_player1.player_hand.cards
      expect(test_player1.player_hand.cards).to eq([])
    end
  end

  describe '#choose_discards' do
    it "should let the player choose which cards to discard" do
      
    end
  end


end
