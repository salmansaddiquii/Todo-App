# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

# Uncomment the line below in case you have `--require rails_helper` in the `.rspec` file
# which prevents rails generators from crashing if migrations haven't been run
require 'rspec/rails'
require 'shoulda/matchers'
require 'factory_bot_rails'
require 'warden/test/helpers'

# Requires supporting ruby files with custom matchers and macros in spec/support/
# and its subdirectories.
Rails.root.glob('spec/support/**/*.rb').each { |f| require f }

# Check for pending migrations and apply them before tests are run.
# If not using ActiveRecord, remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  require 'database_cleaner/active_record' # Adjust this based on your ORM if needed

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  # Devise test helpers for different test types
  config.include Devise::Test::IntegrationHelpers, type: :request # For request specs
  config.include Devise::Test::ControllerHelpers, type: :controller # For controller specs
  config.include Devise::Test::IntegrationHelpers, type: :feature
  # Warden helpers for feature specs
  config.include Warden::Test::Helpers, type: :feature
  config.after(type: :feature) { Warden.test_reset! }

  # Include FactoryBot methods to simplify usage
  config.include FactoryBot::Syntax::Methods

  # Set fixture paths if using fixtures
  config.fixture_path = Rails.root.join('spec/fixtures').to_s

  # Use transactional fixtures for ActiveRecord
  config.use_transactional_fixtures = true

  # Automatically infer spec types from file location
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

  # Additional gem-specific configuration
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
