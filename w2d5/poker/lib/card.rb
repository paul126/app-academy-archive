# -*- coding: utf-8 -*-

class Card
  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUE_STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def render
    VALUE_STRINGS[@value] + SUIT_STRINGS[@suit]
  end

  def ==(other_card)
    self.suit == other_card.suit && self.value == other_card.value
  end
  alias :eql? :==

  def hash
    @suit.hash + @value.hash
  end

end
