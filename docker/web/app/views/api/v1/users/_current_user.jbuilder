json.partial! 'api/v1/users/user', user: user, as: :user
json.recent_tasks_count user.recent_tasks.count
json.pending_tasks_count user.pending_tasks.count
json.pending_code_reviews_count user.pending_code_reviews.count
json.wallet_amount user.wallet_amount
json.breakdown user.breakdown
json.bids @user.bids do |bid|
  json.partial! 'api/v1/bids/bid', bid: bid, as: :bid
  json.project do
    json.partial! 'api/v1/projects/project', project: bid.project, as: :project
  end
  json.user do
    json.partial! 'api/v1/users/user', user: bid.user, as: :user
  end
end