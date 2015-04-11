FactoryGirl.define do

  factory :invitation do
    email {generate(:email)}
  end

end
