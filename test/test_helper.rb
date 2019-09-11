require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'vcr'
require 'webmock/minitest'

require_relative '../lib/user'
require_relative '../lib/channel'
require_relative '../lib/Recepient'
require_relative '../lib/workspace'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
  
  config.filter_sensitive_data("<LOCATIONIQ_TOKEN>") do
    ENV["LOCATIONIQ_TOKEN"]
  end
end
