require 'spec_helper'
require 'bowlr/game'

describe Bowlr::Game do
  let(:game) { Game.new }

  it 'initializes a new game with empty frames' do
    expect(game.frames).to eq([])
  end

  context 'hitting the pins' do
    it 'takes a bunch of inputs and assigns it to frames' do
      game.hit('10')
      game.hit('9')
      game.hit('1')
      game.hit('10')
      expect(game.frames).to eq([[10],[9,1],[10]])
    end
  end

  describe '#frame_scores' do
    it 'returns an array of scores' do
      game.frame_scores.should == []
    end
  end

  describe '#summing_scores' do
    let(:expected_result) { [1,6] }

    before do
      game.frames = [[1,0],[2,3]]
    end


    it 'returns a cumulative result array' do
      expect(game.summing_scores).to eq(expected_result)
    end
  end

end
