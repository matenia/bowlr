module Bowlr
  class ScorePrinter
    attr_accessor :frames

    def initialize(*input_frames)
      @frames = input_frames.flatten
    end

    def output
      frames.map do |frame|
        [
          frame.ball_1,
          frame.ball_2,
          frame.bonus_ball_1,
          frame.bonus_ball_2
        ].compact.join(' ')
      end.join(' | ')
    end
  end
end
