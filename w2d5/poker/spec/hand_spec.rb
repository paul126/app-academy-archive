require 'hand'

describe Hand do

  let(:test_hand) {Hand.new}
  let(:sample_cards) {[Card.new(:hearts, :eight), Card.new(:clubs, :jack), Card.new(:spades, :three), Card.new(:diamonds, :ace), Card.new(:hearts, :king)] }
  let(:sorted_cards) {[Card.new(:spades, :three), Card.new(:hearts, :eight), Card.new(:clubs, :jack), Card.new(:hearts, :king), Card.new(:diamonds, :ace)]}

  describe '#initialize(cards=[])' do
    it "should have an empty array of cards if no argument given" do
      expect(test_hand.cards.count).to eq(0)
    end

  end

  describe '#receive_cards(cards)' do
    it "should put the cards into the hand" do
      test_hand.receive_cards(sample_cards)
      expect(test_hand.cards).to eq(sample_cards)
    end
  end

  describe '#discard_cards(cards)' do
    it "should remove the cards from the hand" do
      test_hand.receive_cards(sample_cards)
      test_hand.discard_cards([sample_cards[0]])
      expect(test_hand.cards.include?(sample_cards[0])).to be(false)
    end
  end

  describe 'sort_cards' do
    it "should sort the cards by value (2 low ace high)" do
      test_hand.cards = sample_cards
      expect(test_hand.sort_cards).to eq(sorted_cards)
    end
  end

  describe '#hand_value' do
    it "should give the total point value of all cards" do
      test_hand.cards = sample_cards
      expect(test_hand.hand_value).to eq(49)
    end

  end

  describe '#straight_flush?' do
    it "should identify a straight" do
      straight_hand = [Card.new(:hearts, :eight), Card.new(:hearts, :nine), Card.new(:hearts, :ten), Card.new(:hearts, :jack), Card.new(:hearts, :queen)]
      test_hand.receive_cards(straight_hand)
      expect(test_hand.straight_flush?).to be(true)
    end
  end

  describe '#four_of_a_kind?' do
    it "should identify a four of a kind" do
      four_of_a_kind_hand = [Card.new(:clubs, :eight), Card.new(:spades, :eight), Card.new(:hearts, :eight), Card.new(:diamonds, :eight), Card.new(:clubs, :jack)]
      test_hand.receive_cards(four_of_a_kind_hand)
      expect(test_hand.four_of_a_kind?).to be(true)
    end
  end

  describe '#full_house?' do
    it "should identify a full house" do
      full_house_hand = [Card.new(:clubs, :eight), Card.new(:spades, :eight), Card.new(:hearts, :eight), Card.new(:hearts, :jack), Card.new(:clubs, :jack)]
      test_hand.receive_cards(full_house_hand)
      expect(test_hand.full_house?).to be(true)
    end
  end

  describe '#flush?' do
    it "should identify a flush" do
      flush_hand = [Card.new(:hearts, :eight), Card.new(:hearts, :jack), Card.new(:hearts, :three), Card.new(:hearts, :ace), Card.new(:hearts, :king)]
      test_hand.receive_cards(flush_hand)
      expect(test_hand.flush?).to be(true)
    end
  end

  describe '#straight?' do
    it "should identify a straight" do
      straight_hand = [Card.new(:clubs, :eight), Card.new(:spades, :nine), Card.new(:hearts, :ten), Card.new(:hearts, :jack), Card.new(:hearts, :queen)]
      test_hand.receive_cards(straight_hand)
      expect(test_hand.straight?).to be(true)
    end
  end

  describe '#three_of_a_kind?' do
    it "should identify a three of a kind" do
      three_of_a_kind_hand = [Card.new(:clubs, :eight), Card.new(:spades, :eight), Card.new(:hearts, :eight), Card.new(:hearts, :jack), Card.new(:hearts, :queen)]
      test_hand.receive_cards(three_of_a_kind_hand)
      expect(test_hand.three_of_a_kind?).to be(true)
    end
  end

  describe '#two_pair?' do
    it "should find two pairs in a hand" do
      two_pair_hand = [Card.new(:clubs, :eight), Card.new(:spades, :eight), Card.new(:hearts, :nine), Card.new(:spades, :nine), Card.new(:hearts, :queen)]
      test_hand.receive_cards(two_pair_hand)
      expect(test_hand.two_pair?).to be(true)
    end
  end

  describe '#beats_hand?(hand)' do
    it "should know if a hand beats another hand" do
      straight_hand = Hand.new([Card.new(:clubs, :eight), Card.new(:spades, :nine), Card.new(:hearts, :ten), Card.new(:hearts, :jack), Card.new(:hearts, :queen)])
      full_house_hand = Hand.new([Card.new(:clubs, :eight), Card.new(:spades, :eight), Card.new(:hearts, :eight), Card.new(:hearts, :jack), Card.new(:clubs, :jack)])
      three_of_a_kind_hand = Hand.new([Card.new(:clubs, :eight), Card.new(:spades, :eight), Card.new(:hearts, :eight), Card.new(:hearts, :jack), Card.new(:hearts, :queen)])

      expect(full_house_hand.beats_hand?(straight_hand)).to be(true)
      expect(straight_hand.beats_hand?(three_of_a_kind_hand)).to be(true)
      expect(three_of_a_kind_hand.beats_hand?(straight_hand)).to be(false)
    end

    it "should determine what hand wins when the hands are the same type"
      #add pair, hand comparison, high card



  end





end
