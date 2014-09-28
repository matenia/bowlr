module Bowlr
  class Game
    attr_accessor :frames
    def initialize
      @frames = []
    end

    def hit(num)
      @frames << num.strip
      print_current_frames
    end

    def usage
      'Enter number of pins knocked down, turn by turn'
    end

    def print_current_frames
      print @frames.inspect
    end
  end
end
