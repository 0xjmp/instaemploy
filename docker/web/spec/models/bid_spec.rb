require 'spec_helper'

describe Bid do
  before :each do
    @bid = create(:bid)
  end

  it 'should advance state' do
    @bid.next_state!
    @bid.reload

    expect(@bid.state).to eq 'started'
  end

  it 'should cancel state' do
    @bid.state = 'started'
    @bid.save!

    @bid.cancel_state!
    @bid.reload

    expect(@bid.state).to eq 'incomplete'
  end

  it 'should have a default state' do
    expect(Bid.default_state).to eq 'incomplete'
  end

end