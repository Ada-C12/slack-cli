#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require_relative 'user'
require_relative 'channel'
#require_relative 'workspace'

Dotenv.load
def main
  puts "Welcome to the Ada Slack CLI!"
  
  puts SlackCLI::Channel.new(01, "zadie", "cute puppies", 2)
  puts SlackCLI::User.new(01, "zadie", "cute puppy", "runnign around")
  
  puts "Thank you for using the Ada Slack CLI"
end

main

#main if __FILE__ == $PROGRAM_NAME