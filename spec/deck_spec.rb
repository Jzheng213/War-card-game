require 'card'
require 'deck'

describe Deck do
  describe "::all_cards" do
    subject(:all_cards) { Deck.all_cards }
    
    it "starts with a count of 52" do
      expect(all_cards.count).to eq(52)
    end
    
    it "returns all cards without duplicates" do
      all_card_vals = Card.suits.product(Card.values).sort
      
      deepdup_cards = all_cards.map { |card| [card.suit, card.value] }.sort
      
      expect(deepdup_cards).to eq(all_card_vals)
    end
  end
  
  let(:sample_cards) do
    sample_cards = [
      Card.new(:spades, :king),
      Card.new(:spades, :Ace),
      Card.new(:clubs, :eight)
    ] 
  end
  describe "#initialize" do
    it "by default fills itself with 52 cards" do
      deck = Deck.new
      expect(deck.count).to eq(52)
    end
    
    it "can be initialized with an array of cards" do
      deck = Deck.new(sample_cards)
      expect(deck.count).to eq(3)
    end
  end

  let(:deck) do
    deck = Deck.new(sample_cards.dup)
  end
    
  it "it does expose cards directly" do
    expect(deck).not_to respond_to(:cards)
  end

  
  describe "#take" do
    it "takes cards off the top of the deck" do
      expect(deck.take(1)).to eq(sample_cards[0..0])
      expect(deck.take(2)).to eq(sample_cards[1..-1])
    end
    
    it "removes cards from the deck on take" do
      
      deck.take(2)
      expect(deck.count).to eq(1)
    end
    
    it "doesn't allow you to take more cards than are in the deck" do
      expect do
        deck.take(4)
      end.to raise_error("not enough cards")
    end
  end

end