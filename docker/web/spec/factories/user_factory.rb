FactoryGirl.define do

	sequence(:email) do |i|
		"email#{i}@gmail.com"
	end

  sequence(:skill_list) do
    "Objective-C, Swift, Ruby, Ruby-on-Rails, HTML, CSS, JavaScript"
  end

  sequence(:github_profile_url) do |i|
    "https://github.com/users/jakenberg#{i}"
  end

  sequence(:username) do |i|
    "username#{i}"
  end

  factory :user do
    email { generate(:email) }
    first_name 'Jr.'
    last_name 'Jake'
    password 'Password'
    password_confirmation { password }
    github_profile_url { generate(:github_profile_url) }
    location 'Los Angeles, CA'
    hireable true
    skill_list { generate(:skill_list) }
    username { generate(:username) }

    after(:build) do |user, eval|
      f = File.open(File.join(Rails.root, 'spec/fixtures/image.gif'))
      user.avatar = Rack::Test::UploadedFile.new(f)
      f.close
    end
  end

  factory :senior, class: 'User' do
    email { generate(:email) }
    first_name 'Sr.'
    last_name 'Jake'
    password 'Password'
    password_confirmation { password }
    github_profile_url { generate(:github_profile_url) }
    company 'Senior Inc.'
    location 'Los Angeles, CA'
    skill_list { generate(:skill_list) }
    username { generate(:username) }
    senior true

    after(:build) do |senior, eval|
      f = File.open(File.join(Rails.root, 'spec/fixtures/image.gif'))
      senior.avatar = Rack::Test::UploadedFile.new(f)
      f.close
    end
  end

  factory :admin, class: 'User' do
    email { generate(:email) }
    first_name 'Admin'
    last_name 'User'
    password 'Password'
    password_confirmation { password }
    location 'Santa Monica, CA'
    skill_list { generate(:skill_list) }
    username { generate(:username) }
    admin true
    company 'Call of Code'

    after(:build) do |user, eval|
      f = File.open(File.join(Rails.root, 'spec/fixtures/image.gif'))
      user.avatar = Rack::Test::UploadedFile.new(f)
      f.close
    end
  end

end
