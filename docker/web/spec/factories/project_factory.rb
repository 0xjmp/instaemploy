FactoryGirl.define do

  factory :project do
  	title "Project Title"
  	description '#### Test Markup!!! ```git clone git@github.com```'
  	repo_url "git@github.com:Jakenberg/call-of-code.git"
		association :user, factory: :senior
		due_date DateTime.now + 100
    skill_list { generate(:skill_list) }
    is_accepted false
  end

end
