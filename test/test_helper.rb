require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'vcr'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/recipient.rb'
require_relative '../lib/user.rb'


VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
end
