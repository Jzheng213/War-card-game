require 'game'
require 'card'

describe Game do
  let(:new_deck) do
  
  end
  
  let(:player1) = double("player")
  let(:player2) = double("player")
  
  describe "#deal_players" do
    game = Game.new(player1, player2)
    
    it "#alternates when it deals"
      game.deal_players(new_deck)
      
  end
end