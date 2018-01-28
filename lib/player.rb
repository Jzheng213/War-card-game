require 'byebug'
require_relative 'player_deck'
class Player
  attr_accessor :deck, :discard
  def initialize(name)
    @name = name
    @discard = PlayerDeck.new
  end
  
  def play_card(visible)
    deck.take(1, visible)
  end
  
  def deck_empty?
    deck.empty?
  end
  
  def shuffle_in_discard
    # debugger
    @deck.return(@discard.dup.shuffle!)
    @discard.empty_deck
  end
  
  def lost?
    @deck.empty? && @discard.empty?
  end
  
  def wins(pile1, pile2)
    @discard.return(pile1)
    @discard.return(pile2)
  end
  
  
end