require 'spec_helper'
require 'bowlr/frame'

describe Bowlr::Frame do

  describe '#initialize' do
    context 'with opts' do
      let(:opts) { { frame_number: 1 } }
      let(:new_frame) { described_class.new(opts) }

      it 'assigns frame_opts' do
        expect(new_frame.frame_number).to eq(1)
      end
    end
  end

  describe '#pin_score' do
    let(:frame_turns) do
      { frame_number: 10, ball_1: 10, bonus_ball_1: 5, bonus_ball_2: 4 }
    end
    let(:tenth_frame) { described_class.new(frame_turns) }

    it 'returns the sum of all balls played' do
      expect(tenth_frame.pin_score).to eq(19)
    end
  end

  describe '#frame_complete?' do
    context 'on the 3rd frame' do
      context 'with only 1 ball played' do
      end
      context 'with both balls played' do
      end
    end

    context 'on the tenth frame' do
      let(:frame) { Frame.new(frame_number: 10) }

      context 'with a spare' do
        before do
          frame.ball_1 = 5
          frame.ball_2 = 5
        end

        it 'is an incomplete turn without bonus ball 1' do
          expect(frame.frame_complete?).to be(false)
        end

        it 'is a complete frame with bonus ball 1 played' do
          frame.bonus_ball_1 = 5
          expect(frame.frame_complete?).to be(true)
        end
      end

      context 'with a strike' do
        before do
          frame.ball_1 = 10
        end

        it 'is an incomplete turn without any bonus balls' do
          expect(frame.frame_complete?).to be(false)
        end

        it 'is an incomplete turn with 1 bonus ball' do
          frame.bonus_ball_1 = 10
          expect(frame.frame_complete?).to be(false)
        end

        it 'is a complete frame with 2 bonus balls' do
          frame.bonus_ball_1 = 10
          frame.bonus_ball_2 = 10
          expect(frame.frame_complete?).to be(true)
        end
      end

      context 'without a strike or spare' do
        before do
          frame.ball_1 = 5
        end

        it 'is an incomplete frame if 1 turn taken' do
          expect(frame.frame_complete?).to be(false)
        end

        it 'is a complete frame if both turns taken' do
          frame.ball_2 = 4
          expect(frame.frame_complete?).to be(true)
        end
      end
    end
  end

  describe 'attempting to cheat on a normal frame' do
    let(:frame) { Frame.new(frame_number: 5) }

    context 'trying to add 11' do
      before do
        frame.add_ball('11')
      end

      it 'does not apply the score' do
        expect(frame.ball_1).to eq(nil)
      end
    end

    context 'with a frame score of 11' do
      before do
        frame.add_ball('5')
        frame.add_ball('6')
      end

      it 'does not apply the second ball' do
        expect(frame.ball_1).to eq(5)
        expect(frame.ball_2).to eq(nil)
      end
    end
  end

  describe 'attempting to cheat on the tenth frame' do
    let(:frame) { Frame.new(frame_number: 10) }

    context 'with a strike and bonus ball 1 being 11' do
      before do
        frame.add_ball('10')
        frame.add_ball('11')
      end

      it 'does not assign bonus_ball_1' do
        expect(frame.bonus_ball_1).to eq(nil)
      end

      it 'does not assign bonus_ball_2' do
        frame.add_ball('5')
        frame.add_ball('6')
        expect(frame.bonus_ball_1).to eq(5)
        expect(frame.bonus_ball_2).to eq(nil)
      end
    end

    context 'with a spare bonus ball 1 being 11' do
      before do
        frame.add_ball('5')
        frame.add_ball('5')
        frame.add_ball('11')
      end

      it 'does not assign bonus_ball_1' do
        expect(frame.bonus_ball_1).to eq(nil)
      end
    end
  end

end
