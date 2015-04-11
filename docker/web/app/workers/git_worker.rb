module GitWorker
  class Upload
    include Sidekiq::Worker
    sidekiq_options queue: :git, retry: 4

    include GitHelper

    def perform(project_id)
      # Find
      project = Project.find(project_id)

      # Clone
      if project.git_url.nil?
        local_url = local_git_path(project) + project.slug + '.git'
        unless File.exist?(local_url)
          git = Git.clone(project.repo_url, "#{project.slug}.git", path: local_git_path(project))
          puts "Creating project repo (#{project.id.to_s}) from #{project.repo_url}"
        else
          git = Git.open("#{local_url}/#{project.slug}/", log: logger)
          puts "Found existing project (#{project.id.to_s}) repo locally at #{git.repo.path}. Retrying upload..."
        end

        # Upload to S3
        init_aws
        remote_url = "#{remote_git_path(project) + project.slug}.git"
        obj = @s3.put_object(key: remote_url)

        # Flush cache
        FileUtils.rm_rf(local_url)
        puts "Flushing project (#{project.id}) repo temp files at #{local_url}"

        # Update project
        project.git_url = obj.wait_until_exists.presigned_url('get')
        project.save!

        puts "Uploaded project (#{project.id}) repo to #{project.git_url}. Exiting..."
      else
        puts 'Already created repo. Exiting...'
      end
    end

    private

    def logger
      if Rails.env.development? or Rails.env.test?
        Logger.new(STDOUT)
      end
    end

    def zip_dir(path)
      path.sub!(%r[/$],'')
      archive = File.join(path,File.basename(path))+'.zip'
      FileUtils.rm archive, :force=>true

      Zip::ZipFile.open(archive, 'w') do |zipfile|
        Dir["#{path}/**/**"].reject{|f|f==archive}.each do |file|
          zipfile.add(file.sub(path+'/',''),file)
        end
      end
    end
  end

  class Remove
    include Sidekiq::Worker
    sidekiq_options queue: :git, retry: 2

    include GitHelper

    def perform(project_id)
      project = Project.find(project_id)

      unless project.git_url.nil?
        init_aws
        remote_url = "#{remote_git_path(projet) + project.slug}.git"
        @s3.delete_objects({
          delete: {
            objects: [{ key: remote_url }],
            quiet: true
          }
        })

        project.git_url = nil
        project.save!

        puts "Removed project (#{project.id}) repo from S3. Exiting..."
      else
        puts "No project (#{project.id}) repo exists in S3. Exiting..."
      end
    end
  end
end