require 'card'

describe Card do

  let(:test_card) { Card.new(:hearts, :ace) }

  describe '#initialize' do
    it "should create new card with a given suit and value" do
      expect{Card.new}.to raise_error(ArgumentError)
    end

  end

  describe '#suit' do
    it "should return the suit value as a symbol" do
      expect(test_card.suit).to eq(:hearts)
      expect(test_card.suit).not_to eq(:clubs)
    end
  end

  describe '#value' do
    it "should return the card value as a symbol" do
      expect(test_card.value).to eq(:ace)
      expect(test_card.suit).not_to eq(:jack)
    end

  end

  describe '#render' do
    it "should return the card as a string" do
      expect(test_card.render).to eq("A♥")
    end
  end

  describe '#eql?' do
    it "should compare to cards for their value and suit" do
      expect(test_card.eql?(Card.new(:hearts, :ace))).to be(true)
      expect(test_card.eql?(Card.new(:clubs, :three))).to be(false)
    end

  end

end
