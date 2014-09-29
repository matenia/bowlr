module Bowlr
  class Frame
    attr_accessor :frame_number, :ball_1, :ball_2,
      :bonus_ball_1, :bonus_ball_2, :frame_score, :bonus_ball_count

    def initialize(opts = {})
      opts.each do |k,v|
        self.send("#{k}=", v)
      end
    end

    def add_ball(pins)
      number = pins.to_s[/\d+/]
      return if number.nil? || number.to_i > 10 || number.to_i < 0 # invalid turn
      add_to_current_ball(number.to_i)
      self.frame_score = pin_score
    end

    def pin_score
      return 0 unless frame_complete?
      [ball_1, ball_2, bonus_ball_1, bonus_ball_2].map(&:to_i).reduce(&:+)
    end

    def frame_complete?
      return true if frame_number < 10 && (turns_taken? || strike?)
      return true if frame_number == 10 && strike? && both_bonus_turns_taken?
      return true if frame_number == 10 && spare? && one_bonus_turn_taken?
      return true if frame_number == 10 && turns_taken? && !strike? && !spare?
      false
    end

    def strike?
      ball_1 == 10
    end

    def add_bonus(val)
      self.frame_score += val.to_i
    end

    def spare?
      !strike? && (ball_1.to_i + ball_2.to_i == 10)
    end

    def applicable_bonus_score
      [ball_1, ball_2, bonus_ball_1, bonus_ball_2].compact.first(2).reduce(&:+)
    end

    private

    def add_to_current_ball(pins)
      if ball_1.nil?
        self.ball_1 = pins
      elsif frame_number < 10
        self.ball_2 = pins
        self.ball_2 = nil if pin_score > 10
      elsif frame_number == 10
        if ball_2.nil? && !strike?
          self.ball_2 = pins
          self.ball_2 = nil if pin_score > 10
        elsif bonus_ball_1.nil? && (strike? || spare?)
          self.bonus_ball_1 = pins
        elsif bonus_ball_2.nil? && strike?
          self.bonus_ball_2 = pins
        end
      end
    end

    def turns_taken?
      !ball_1.nil? && !ball_2.nil?
    end

    def both_bonus_turns_taken?
      !bonus_ball_1.nil? && !bonus_ball_2.nil?
    end

    def one_bonus_turn_taken?
      !bonus_ball_1.nil?
    end
  end
end

=begin

    def add_to_current_ball(pins)
      if ball_1.nil?
        self.ball_1 = pins
        return
      end

      if frame_number <= 10 && !strike?
        if ball_2.nil?
          self.ball_2 = pins
          return
        end
      else # we're in bonus mode
        if strike?
          if bonus_ball_1.nil?
            self.bonus_ball_1 = pins
            return
          else # second bonus ball
            self.bonus_ball_2 = pins
            return
          end
        elsif spare?
          self.bonus_ball_1 = pins
        end
      end
    end
=end
