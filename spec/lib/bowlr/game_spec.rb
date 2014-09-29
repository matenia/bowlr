require 'spec_helper'
require 'bowlr/game'
require 'bowlr/score_card'

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
      expect(game.frames.length).to eq(3)
    end

    it 'does not let you take more than 10 frames' do
      10.times do
        game.hit('9')
        game.hit('0')
      end
      expect(game.game_complete?).to be(true)
    end
  end

  shared_examples_for 'complete game' do
    it 'returns the expected scorecard' do
      expect(ScoreCard.new(game.frames).output).to eq(expected_scorecard)
    end
  end

  describe 'game of spares' do
    let(:expected_scorecard) do
      "\n15 | 30 | 45 | 60 | 75 | 90 | 105 | 120 | 135 | 150"
    end
    before do
      21.times { game.hit('5') }
    end

    it_behaves_like('complete game')
  end

  describe 'perfect game' do
    let(:expected_scorecard) do
      "\n30 | 60 | 90 | 120 | 150 | 180 | 210 | 240 | 270 | 300"
    end
    before do
      12.times { game.hit('10') }
    end

    it_behaves_like('complete game')
  end

  describe 'gutter game' do

    let(:expected_scorecard) do
      "\n0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0"
    end
    before do
      20.times { game.hit('0') }
    end

    it_behaves_like('complete game')
  end

  describe '#usage' do
    it 'is a string' do
      expect(game.usage).to be_a(String)
    end
  end

end
