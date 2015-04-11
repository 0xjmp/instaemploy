require 'spec_helper'

describe StripeAccountsWorker do
  it { is_expected.to be_processed_in :accounts }
  it { is_expected.to be_retryable 4 }

  let(:bid){create(:bid)}

  it 'should perform_async' do
    StripeAccountsWorker.perform_async(bid.id)
    expect(StripeAccountsWorker.jobs.size).to eq 2
  end

  it 'should perform' do
    StripeAccountsWorker.new.perform(bid.id)
    bid.reload
    expect(bid.state).to eq 
  end

end