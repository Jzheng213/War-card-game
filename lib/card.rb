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

  WAR_VALUE = {
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace   => 14
  }

  def self.suits
    SUIT_STRINGS.keys
  end

  def self.values
    VALUE_STRINGS.keys
  end

  attr_accessor :face_up
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
    @face_up = false
  end

  def war_value
    WAR_VALUE[value]
  end

  def == (other_card)
    return false if other_card.nil?
    return false unless other_card.is_a?(Card)

    [:suit, :value].all? do |attr|
      self.send(attr) == other_card.send(attr)
    end
  end

  def to_s
    if face_up
      VALUE_STRINGS[value] + SUIT_STRINGS[suit]
    else
      ""
    end
  end
end
