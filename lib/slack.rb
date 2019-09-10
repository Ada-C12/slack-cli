#!/usr/bin/env ruby
require "dotenv"
require "httparty"

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'vcr'
require "dotenv"
require "httparty"
require 'table_print'
require_relative "recipient"
require_relative "slack"
require_relative "user"
require_relative "workspace"
require_relative "channel"

Dotenv.load

Dotenv.load

def print_users
  p WS.users
end

# tp workspace.users, "name", "real_name", "slack_id"





def main
  puts "Welcome to the Ada Slack CLI!"
  again = true
  while again
    puts "What would you like to do"
    end
    
    puts "Thank you for using the Ada Slack CLI"
  end
  
  # main if __FILE__ == $PROGRAM_NAME
  
  