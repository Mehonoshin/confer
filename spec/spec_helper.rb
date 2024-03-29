# encoding: UTF-8

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'vcr'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

Capybara.javascript_driver = :poltergeist
Capybara.app_host = 'http://confer.dev'
Capybara.server_port = 8097

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = Rails.root.join("spec", "vcr")
  c.hook_into :fakeweb
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :rspec
  # config.mock_with :flexmock
  # config.mock_with :rr
  #config.mock_with :mocha

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Включать по необходимости
  # config.filter_run :focus => true
  # config.filter_run :success => true

end

