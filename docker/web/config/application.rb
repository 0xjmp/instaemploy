require File.expand_path('../boot', __FILE__)
require 'rails/all'
require 'omniauth'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require './app/middleware/angular_templates'

if Rails.env.development?
  require 'dotenv'

  Dotenv.load(
    File.expand_path("../../.env.#{Rails.env}", __FILE__),
    File.expand_path("../../.env",  __FILE__)
  )
end

module CallOfCode
  class Application < Rails::Application

    config.time_zone = 'Pacific Time (US & Canada)'

    config.assets.initialize_on_precompile = false
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')

    config.i18n.enforce_available_locales = true
    config.action_controller.allow_forgery_protection = false

    config.generators do |g|
      g.template_engine :slim
      g.test_framework :rspec, fixture: :factory_girl
    end

    config.active_record.raise_in_transactional_callbacks = true
  end
end