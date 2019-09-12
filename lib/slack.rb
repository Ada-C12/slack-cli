#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'recipient'
require_relative 'user'
require_relative 'channel'
require "table_print"

Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  
  options = "1. List Users in the Workspace \n2. List Channels in the Workspace\n3. Quit program"
  puts options
  selection = gets.chomp
  
  until selection == "3" 
    if selection == "1"
      tp SlackCLI::User.list
    elsif selection == "2"
      tp SlackCLI::Channel.list
    end
    puts options
    selection = gets.chomp
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

