class PaymentsWorker
  include Sidekiq::Worker

  def perform(bid_id)
    bid = Bid.find(bid_id)
    Stripe::Transfer.create(
      amount: bid.amount
    )
  end

end