module Bowlr
  class ScoreCalculator
    attr_accessor :frames

    def initialize(*frames_list)
      @frames = frames_list.flatten.last(3)
    end

    def update_frame_scores
      return if frames.length < 2
      # we only ever want to look at the last 3 frames
      if frames[0].strike? && frames[1].strike?
        frames[0].add_bonus(frames.last.ball_1)
      end

      if frames[0].spare? && frames.length == 2
        # we're in the second frame here
        frames[0].add_bonus(frames[1].ball_1)
      end

      return if frames[2].nil?

      if frames[1].strike?
        frames[1].add_bonus(frames[2].applicable_bonus_score)
      elsif frames[1].spare?
        frames[1].add_bonus(frames[2].ball_1)
      end
    end
  end
end
