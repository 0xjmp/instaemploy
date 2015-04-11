FactoryGirl.define do

  sequence(:bid_price) do |i|
    "$#{i}.00"
  end

  factory :bid do
    association :project, factory: :project
    association :user
    price {generate(:bid_price)}
  end

end
