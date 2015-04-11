require 'fog/aws/storage'
require 'carrierwave'

CarrierWave.configure do |config|
  config.storage = Rails.env.test? ? :file : :fog
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_KEY']
  }
  config.fog_directory = ENV['AWS_S3_BUCKET']
  config.fog_public = false
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
  config.enable_processing = Rails.env.production?
end