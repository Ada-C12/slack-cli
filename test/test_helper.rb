require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'webmock/minitest'
require 'dotenv'

Dotenv.load


require 'vcr'
require_relative '../lib/channel'
require_relative '../lib/user'
require_relative '../lib/recipient'
require_relative '../lib/workspace'
# require_relative 'recipient_test'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
  
  config.default_cassette_options = {
    :record => :new_episodes,
    :match_requests_on => [:method, :uri, :body],
  }
  config.filter_sensitive_data("<SLACK_TOKEN>") do
    ENV["SLACK_TOKEN"]
  end
end

