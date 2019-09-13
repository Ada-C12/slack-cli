require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end
require "dotenv"
Dotenv.load

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'vcr'
require 'webmock/minitest'
require 'httparty'

require_relative '../lib/slack_api_error'
require_relative '../lib/recipient'
require_relative '../lib/channel'
require_relative '../lib/user'
require_relative '../lib/workspace'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
  
  # Don't leave our token lying around in a cassette file.
  config.filter_sensitive_data("<SLACK_TOKEN>") do
    ENV["SLACK_TOKEN"]
  end
end


