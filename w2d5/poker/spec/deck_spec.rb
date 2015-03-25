require 'deck'

describe Deck do

  let(:test_deck) { Deck.new }

  describe '#initialize' do

    it "should have 52 cards" do
      expect(test_deck.count).to eq(52)
    end

    it "all cards should be unique" do
      expect(test_deck.cards.count).to eq(test_deck.cards.uniq.count)
    end


  end

  describe '#take(num)' do
    it "should return the number of cards requested" do
      some_cards = test_deck.take(5)
      expect(some_cards.count).to eq(5)
      some_cards.each do |card|
        expect(card).to be_a(Card)
      end
    end

    it "should remove the dealt cards frome the deck" do
      some_cards = test_deck.take(5)
      expect(test_deck.count).to eq(47)

      deck_cards = test_deck.cards
      some_cards.each do |card|
        expect(deck_cards.include?(card)).to be(false)
      end
    end

  end

  describe '#shuffle!' do
    it "should shuffle the order of the cards in deck" do
      temp_deck = test_deck.cards
      test_deck.shuffle!
      expect(temp_deck).not_to eq(test_deck.cards)
    end
  end

  describe '#cards' do
    it "should not be the same as the deck" do
      some_cards = test_deck.cards
      some_cards.pop

      expect(some_cards.count == test_deck.cards.count).to be(false)
    end
  end

  describe '#count' do
    it "should return the number of cards in the deck" do
      expect(test_deck.count).to eq(52)
    end

    it "should reflect changes to the deck" do
      start_count = test_deck.count
      test_deck.take(5)
      expect(start_count).not_to eq(test_deck.count)
    end
  end


end
