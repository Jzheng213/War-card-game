require 'byebug'
require_relative 'deck'
require_relative 'player'

class Game
  attr_accessor :player1, :player2, :pile1, :pile2
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @pile1 = []
    @pile2 = []
  end
    
  def render
    system("clear")
    p "player1 discard #{@player1.discard.count}"
    p "player1 deck #{@player1.deck.count}"
    print @player1.deck.top_card.to_s
    @pile1.each do |card|
      print card.to_s
    end
    p ""
    @pile2.each do |card|
      print card.to_s
    end
    print @player2.deck.top_card.to_s
    p "player2 discard #{@player2.discard.count}"
    p "player2 deck #{@player2.deck.count}"
    sleep(0.02)
  end
  
  def deal_players(deck)
    deck1, deck2 = PlayerDeck.new, PlayerDeck.new
    
    new_deck = deck.dup
    new_deck.shuffle!
    
    until new_deck.count == 0
      deck1.add(new_deck.take(1))
      deck2.add(new_deck.take(1))
    end
    
    player1.deck, player2.deck = deck1, deck2
  end
  
  def play
    until game_over?
      
      render
      player1.shuffle_in_discard if player1.deck_empty?
      player2.shuffle_in_discard if player2.deck_empty?
      
      @pile1 += player1.play_card(true)
      @pile2 += player2.play_card(true)
      render
      sleep(1)
      case @pile1.last.war_value <=> @pile2.last.war_value
      when -1
        player1.wins(pile1, pile2)
        @pile1, @pile2 = [], []
      when 0
        war
      when 1
        player2.wins(pile1, pile2)
        @pile1, @pile2 = [], []
      end
    end
    
  end
  
  def war
    @pile1 += player1.play_card(false)
    @pile2 += player2.play_card(false)
  end
  
  def game_over?
    player1.lost? || player2.lost?
  end
  
end

if __FILE__ == $PROGRAM_NAME
  player1 = Player.new("player1")
  player2 = Player.new("player2")
  
  # new_deck = []
  # 
  # 10.times do
  #   new_deck << Card.new(:spades, :ace)
  #   new_deck << Card.new(:hearts, :queen)
  # end
  # 
  # 
  # p "new_deck"
  # new_deck.each do |card|
  #   p card
  # end
  # 
  deck = Deck.new
  game = Game.new(player1, player2)
  game.deal_players(deck)
  
  p "player1.deck"
  player1.deck.each do |card|
    p card
  end
  
  p "player2.deck"
  player2.deck.each do |card|
    p card
  end
  
  p player1.deck.count
  p player2.deck.count
  
  game.play
end