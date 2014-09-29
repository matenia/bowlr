require 'bowlr/turn_validator'

module Bowlr
  class Game
    attr_accessor :frames, :turn

    def initialize
      @turn = []
      @frames = []
    end

    def hit(num)
      if can_take_turn?
        turn.push(num.strip)
        if turn_valid?
          turn.map!(&:to_i)
          group_frames
        else
          turn.pop
          nil
        end
      else
        print "\nGame Over, Type Exit and run again\n"
      end
    end

    def can_take_turn?
      true if frames.length <= 10
    end

    def turn_valid?
      TurnValidator.validate(turn)
    end

    def group_frames
      if turn == [10] || turn.length == 2
        frames << turn
        @turn = []
      end
    end

    def print_current_frames
      if turn == []
        frames.each do |frame|
          print "#{frame.join(' ')} | "
        end
        print_current_score
      end
    end

    # generate array of frame scores
    def frame_scores
      totals = []
      frames.length.times do |turn|
        score = frames[turn].reduce(&:+)
        if turn > 0 && frames[turn - 1].reduce(&:+) == 10
          totals[turn - 1] += score
        end
        if turn > 1 && frames[(turn - 2)..(turn - 1)] == [[10], [10]]
          totals[turn - 2] += frames[turn].first.to_i
        end
        totals << score
      end
      totals
    end

    def summing_scores
      # given an array of frame_scores, return an array of cumulative results
      frame_scores.inject([]) do |score_sum, score|
        score_sum + [(score_sum.last || 0) + score]
      end
    end

    def print_current_score
      scorecard = summing_scores
      print "\n #{scorecard.join(' | ')}"
    end

    def usage
      'Enter number of pins knocked down, turn by turn'
    end
  end

end
