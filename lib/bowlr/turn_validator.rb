module Bowlr
  class TurnValidator
    def self.validate(turns)
      min_turn_gt_zero?(turns) && turns_sum_lte_ten?(turns)
    end

    def self.min_turn_gt_zero?(turns)
      turns.map(&:to_i).min >= 0
    end

    def self.turns_sum_lte_ten?(turns)
      turns.map(&:to_i).reduce(&:+) <= 10
    end
  end
end
