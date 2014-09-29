require 'bowlr/turn_validator'
require 'bowlr/score_printer'
require 'bowlr/score_card'
require 'bowlr/frame'
require 'bowlr/score_calculator'

module Bowlr
  class Game
    attr_accessor :frames, :turn, :max_frames, :current_frame

    def initialize
      @turn = []
      @frames = []
      @max_frames = 10
      @current_frame = new_frame
    end

    def hit(pins)
      current_frame.add_ball(pins)

      if current_frame.frame_complete?
        self.frames.push(current_frame)
        self.current_frame = new_frame
        ScoreCalculator.new(frames).update_frame_scores
        print ScorePrinter.new(frames).output
        print ScoreCard.new(frames).output
      end

      if game_complete?
        print "\n Game Total:\n"
        print ScorePrinter.new(frames).output
        print ScoreCard.new(frames).output
        print "\nGame Over, Type Exit and run again"
      end
    end

    def game_complete?
      frames.length == 10
    end

    def usage
      'Enter number of pins knocked down, turn by turn'
    end

    private

    def new_frame
      self.current_frame = Frame.new(frame_number: frames.length + 1)
    end

  end

end
