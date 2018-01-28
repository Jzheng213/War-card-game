require 'byebug'
require_relative 'card'

class Deck
  def self.all_cards
    combo = Card.suits.product(Card.values)
    combo.map { |suit, value| Card.new(suit, value) }
  end
  
  def initialize(cards = Deck.all_cards)
    @cards = cards
  end
  
  def count
    cards.count
  end
  
  def shuffle!
    @cards.shuffle!
  end
  
  def take(num)
    raise "not enough cards" if num > count
    cards.shift(num)
  end
  def return(new_cards)
    
    face_down_cards = turn_all_cards_down(new_cards)
    @cards += face_down_cards
  end
  
  def inspect
    "suit: #{suit}, value: #{value}"
  end
  
  def top_card
    @cards.first
  end
  
  def each(&prc)
    @cards.each do |card|
      prc.call(card)
    end
  end
  
  private
  attr_accessor :cards

  def turn_all_cards_down(new_cards)
    new_cards.each {|card| card.face_up = false}
  end
  
end


