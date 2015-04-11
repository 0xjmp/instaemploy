json.bid do
  json.partial! 'api/v1/bids/bid', bid: @bid, as: :bid
end