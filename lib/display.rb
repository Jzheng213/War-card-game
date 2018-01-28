
class Display

  def initialize(game)
    @game = game
  end

  def render
    system("clear")
    p '---| player 1 |-------------| player 2 |---'
    p "discard #{@game.player1.discard.count} deck #{@game.player1.deck.count}          deck #{@game.player2.deck.count} discard #{@game.player2.discard.count}"

    p "    #{print_card(@game.player1.deck.top_card)}   #{print_card(@game.player1.discard.top_card)}             #{print_card(@game.player2.deck.top_card)}   #{print_card(@game.player2.discard.top_card)}"
    @game.pile1.each_with_index do |card, idx|
      print "pile #{idx}   #{print_card(card)}                    #{print_card(@game.pile2[idx])}"
      print "\n"
      sleep(2) if idx > 1
    end
    sleep(0.1)
  end

  def print_card(card)
    return "[  ]" if card.nil?

    if card.face_up == true
      "[#{card.to_s}]"
    else
      "[xx]"
    end
  end
end
