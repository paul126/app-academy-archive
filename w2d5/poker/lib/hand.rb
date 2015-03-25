require_relative 'deck'

class Hand

  CARD_VALUES = {
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace   => 14
  }

  attr_accessor :cards

  def initialize(cards=[])
    @cards = cards
  end

  def receive_cards(new_cards)
    @cards.concat(new_cards)
  end

  def discard_cards(old_cards)
    @cards -= old_cards
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    (cards[0].value == cards[1].value &&
     cards[0].value == cards[2].value &&
     cards[0].value == cards[3].value) ||
    (cards[1].value == cards[2].value &&
     cards[1].value == cards[3].value &&
     cards[1].value == cards[4].value)
  end

  def full_house?
    (cards[0].value == cards[1].value &&
     cards[0].value == cards[2].value &&
     cards[3].value == cards[4].value) ||
    (cards[0].value == cards[1].value &&
     cards[2].value == cards[3].value &&
     cards[2].value == cards[4].value)
  end

  def flush?
    cards[1..-1].all? { |card| card.suit == cards[0].suit }
  end

  def straight?
    CARD_VALUES[cards[1].value] == CARD_VALUES[cards[0].value] + 1 &&
    CARD_VALUES[cards[2].value] == CARD_VALUES[cards[1].value] + 1 &&
    CARD_VALUES[cards[3].value] == CARD_VALUES[cards[2].value] + 1 &&
    CARD_VALUES[cards[4].value] == CARD_VALUES[cards[3].value] + 1
  end

  def three_of_a_kind?
    (cards[0].value == cards[1].value &&
     cards[0].value == cards[2].value) ||
    (cards[1].value == cards[2].value &&
     cards[1].value == cards[3].value) ||
    (cards[2].value == cards[4].value &&
     cards[2].value == cards[4].value)
  end

  def two_pair?
    pair_count = 0
    @cards.each_with_index do |card, i|
      next if i + 1 == @cards.length
      if @cards[i+1].value == card.value
        pair_count += 1
      end
    end
    pair_count == 2
  end

  def a_pair?
    @cards.each_with_index do |card, i|
      next if i + 1 == @cards.length
      return true if @cards[i+1].value == card.value
    end
    false
  end

  def sort_cards
    @cards.sort_by!{ |card| CARD_VALUES[card.value]}
  end

  def hand_value
    @cards.inject(0) do |total, card|
      total + CARD_VALUES[card.value]
    end
  end

  def beats_hand?(hand)
    hand_ranks = hand_rank([self, hand])
    if hand_ranks[0] != hand_ranks[1]
      hand_ranks[0] > hand_ranks[1]
    else
      tie_breaker?(hand)
    end
  end

  def hand_rank(hand_arr)
    hand_value_arr = [0,0]
    hand_arr.each_with_index do |hand, i|
      if hand.straight_flush?
        hand_value_arr[i] = 8
      elsif hand.four_of_a_kind?
        hand_value_arr[i] = 7
      elsif hand.full_house?
        hand_value_arr[i] = 6
      elsif hand.flush?
        hand_value_arr[i] = 5
      elsif hand.straight?
        hand_value_arr[i] = 4
      elsif hand.three_of_a_kind?
        hand_value_arr[i] = 3
      elsif hand.two_pair?
        hand_value_arr[i] = 2
      elsif hand.a_pair?
        hand_value_arr[i] = 1
      end
    end
    hand_value_arr
  end

end
