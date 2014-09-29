require 'spec_helper'

require 'bowlr/turn_validator'

describe Bowlr::TurnValidator do
  describe 'validate a set of turn' do
    context 'with a valid turn' do
      it 'returns true for [10]' do
        expect(described_class.validate(['10'])).to eq(true)
      end

      it 'returns true for [4,3]' do
        expect(described_class.validate(['4','3'])).to eq(true)
      end
    end

    context 'with an invalid turn' do
      it 'returns false for [11]' do
        expect(described_class.validate(['11'])).to eq(false)
      end

      it 'returns false for [5,6]' do
        expect(described_class.validate(['5','6'])).to eq(false)
      end

      it 'returns false for [-1, 5]' do
        expect(described_class.validate(['-1','5'])).to eq(false)
      end
    end
  end
end
