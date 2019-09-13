require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

require 'httparty'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'vcr'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# VCR.configure do |config|
#   config.cassette_library_dir = "test/cassettes"
#   config.hook_into :webmock
# end

require_relative "../lib/recipient.rb"
require_relative "../lib/user.rb"
require_relative "../lib/channel.rb"
require_relative "../lib/slack.rb"
require_relative "../lib/workspace.rb"
require 'dotenv'
Dotenv.load