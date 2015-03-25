require_relative 'hand'

class Player

  BASE_POT = 200

  attr_accessor :player_hand, :pot

  def initialize
    @pot = BASE_POT
    @player_hand = Hand.new
  end

  def display_hand
    @player_hand.each do |card|
      card.render
    end
  end

  def choose_discards
    puts "What cards do you want to discard?"

  end


end
