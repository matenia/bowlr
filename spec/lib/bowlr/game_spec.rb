require 'spec_helper'
require 'bowlr/game'

describe Bowlr::Game do

  it 'initializes a new game with empty frames' do
    expect(subject.frames).to eq([])
  end

end
