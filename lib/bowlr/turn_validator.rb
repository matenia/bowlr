module Bowlr
  class TurnValidator
    def self.validate(turns)
      turns.map(&:to_i).min >= 0 && turns.map(&:to_i).reduce(&:+) <= 10
    end
  end
end
