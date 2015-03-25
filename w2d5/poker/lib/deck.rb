require_relative 'card'

class Deck

  def initialize
    @deck = self.class.make_full_deck
  end

  def self.make_full_deck
    deck_array = []

    Card::SUIT_STRINGS.each_key do |suit|
      Card::VALUE_STRINGS.each_key do |value|
      deck_array << Card.new(suit, value)
      end
    end
    deck_array
  end

  def count
    @deck.count
  end

  def cards
    @deck.map{|card| card.dup}
  end

  def take(num)
    dealt_cards = []
    num.times do
      dealt_cards << @deck.pop
    end
    dealt_cards
  end

  def shuffle!
    @deck = @deck.shuffle
    nil
  end
end
