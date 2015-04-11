# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rails_helper'
require 'rspec/rails'
require 'simplecov'
require 'database_cleaner'
require 'devise'
require 'factory_girl_rails'
require 'simplecov'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.ignore_hidden_elements = false

include ActionDispatch::TestProcess

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each{|f| require f}

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

SimpleCov.start

Sidekiq::Testing.fake!

RSpec.configure do |config|

  config.infer_base_class_for_anonymous_controllers = false
  config.use_transactional_fixtures = false
  config.order = :random

  config.before(:each) do
    Warden.test_mode!
    Fog.mock!
    Fog::Mock.reset
    Sidekiq::Worker.clear_all
  end

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include Devise::TestHelpers, type: :controller
  config.include Warden::Test::Helpers
  config.include FactoryGirl::Syntax::Methods

  config.extend ControllerHelpers, type: :controller

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:all) do
    DatabaseCleaner.start
    Warden.test_mode!
  end

  config.after(:each) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"])
  end

  config.after(:all) do
    Warden.test_reset!
    DatabaseCleaner.clean
  end

  config.render_views = true
end

RSpec::Sidekiq.configure do |config|
  config.warn_when_jobs_not_processed_by_sidekiq = false
end