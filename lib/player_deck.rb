require_relative 'deck'

class PlayerDeck < Deck
  def initialize
    @cards = []
  end
    
  def add(card)
    @cards += card
  end
  
  def take(n, visible = false)
    raise "can't take more than one card" if n > 1
    next_card = cards.shift(n)
    next_card.first.face_up = true if visible
    next_card
  end
  
  def empty?
    @cards.count == 0
  end
  
  def empty_deck
    @cards = []
  end
  
  private 
  attr_accessor :cards
end