module Bowlr
  class ScoreCard
    attr_accessor :scores

    def initialize(*frame_scores)
      @scores = frame_scores.flatten.map(&:frame_score)
    end

    def output
      "\n#{cumulative.join(' | ')}"
    end

    private

    def cumulative
      scores.inject([]) do |score_sum, score|
        score_sum + [(score_sum.last || 0) + score]
      end
    end
  end
end
