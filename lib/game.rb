require 'byebug'
require_relative 'deck'
require_relative 'player'
require_relative 'display'

class Game
  attr_accessor :player1, :player2, :pile1, :pile2
  def initialize(player1, player2)
    @display = Display.new(self)
    @player1 = player1
    @player2 = player2
    @pile1 = []
    @pile2 = []
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
      @display.render

      player1.shuffle_in_discard if player1.deck_empty?
      player2.shuffle_in_discard if player2.deck_empty?

      @pile1 += player1.play_card(true)
      @pile2 += player2.play_card(true)

      @display.render

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

  deck = Deck.new
  game = Game.new(player1, player2)
  game.deal_players(deck)
  game.play
end
