module GitHelper

  def local_git_path(resource)
    "tmp/#{resource.class.name.pluralize.downcase}/#{resource.id}/"
  end

  def remote_git_path(resource)
    "uploads/#{resource.class.name.pluralize.downcase}/#{resource.id}/"
  end

  def init_aws
    @s3 = Aws::S3::Bucket.new(name: ENV['AWS_S3_BUCKET'], region: ENV['AWS_REGION'])
  end

end