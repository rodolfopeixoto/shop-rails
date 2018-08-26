require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include ActiveSupport::Testing::TimeHelpers
  config.order = "random"
  
  config.use_transactional_fixtures = true

  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.lint
  end
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
