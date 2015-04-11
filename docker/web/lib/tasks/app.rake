namespace :app do
	desc 'setup the initial db'
	task setup: :environment do
		Rake::Task['db:reset'].invoke
	end

  namespace :load do
    task test_data: :environment do
      image = File.open(File.join(Rails.root, 'spec/fixtures/image.gif'))

      user = User.where(username: 'jakenberg').first
      user.avatar = image
      user.senior = true
      user.admin = true
      user.save!

      (1..26).each do |i|
        Project.create!({
          title: "Project #{i}",
          description: "Description #{i}",
          repo_url: "git@github.com:Instaemploy/instaemploy.git",
          due_date: DateTime.now + 5.days,
          avatar: image,
          user: user,
          views: rand(0..10000)
        })
        puts "Created new project (#{i})"
      end

      image.close
    end
  end
end