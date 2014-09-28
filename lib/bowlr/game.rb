require 'bowlr/turn_validator'

module Bowlr
  class Game
    attr_accessor :frames, :turn

    def initialize
      @turn = []
      @frames = []
    end

    def hit(num)
      @turn.push(num.strip)
      if turn_valid?
        @turn.map!(&:to_i)
        group_frames
      else
        @turn.pop
        nil
      end
    end

    def turn_valid?
      TurnValidator.validate(@turn)
    end

    def group_frames
      if @turn == [10] || @turn.length == 2
        @frames << turn
        @turn = []
      end
    end


    def print_current_frames
      if @turn == []
        @frames.each do |frame|
          print "#{frame.join(' ')} | "
        end
        print_current_score
      end
    end

    # generate array of frame scores
    def frame_scores
      totals = []
      @frames.length.times do |turn|
        score = @frames[turn].reduce(&:+)
        if turn > 1 && @frames[turn - 1].reduce(&:+) == 10
          totals[turn - 1] += score
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
      scorecard = []
      @frames.length.times do |frame_index|
        frame_score = @frames[frame_index].map(&:to_i).reduce(&:+)
        if frame_index == 0
          scorecard.push(frame_score)
        else
          if frame_index > 1
            if @frames[(frame_index - 2)..(frame_index - 1)] == [['10'], ['10']]
              scorecard[frame_index - 2] += @frames[frame_index].first.to_i
            end
          end
          previous_frame = @frames[frame_index - 1].map(&:to_i)
          if previous_frame == [10]
            scorecard[frame_index - 1] += frame_score
          elsif previous_frame.reduce(&:+) == 10
            scorecard[frame_index - 1] += @frames[frame_index].first.to_i
          end
          scorecard.push(scorecard.last + frame_score)
        end
      end
      print "\n #{scorecard.join(' | ')}"
    end

    def usage
      'Enter number of pins knocked down, turn by turn'
    end
  end

end
