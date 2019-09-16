require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'vcr'


require_relative '../lib/channel.rb'
require_relative '../lib/user.rb'
require_relative '../lib/workspace.rb'
require_relative '../lib/recipient.rb'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    record: :new_episodes, # record new data when we don't have it
    match_requests_on: [:method, :uri, :body] # match all of these
  }
  
  config.filter_sensitive_data("SLACK_TOKEN>") do
    ENV["SLACK_TOKEN"]
  end
end
