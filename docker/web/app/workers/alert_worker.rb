class AlertWorker
  include Sidekiq::Worker

  def perform
    ActsAsTaggableOn::Tag.where(created_at: DateTime.now-1.day).each do |tag|
      Alert.tagged_with(tag.name).each do |alert|
        alert.notify
      end
    end
  end

end