#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'recipient'
require_relative 'user'
require_relative 'channel'
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  
  options = "1. List Users in the Workspace \n2. List Channels in the Workspace\n3. Quit program"
  puts options
  selection = gets.chomp
  
  until selection == "3" 
    if selection == "1"
      # method to list users in workspace
      # SlackCLI.list_users
      puts "You selected 1"
    elsif selection == "2"
      puts "you selected 2"
    end
    puts options
    selection = gets.chomp
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

