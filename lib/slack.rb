#!/usr/bin/env ruby
require "dotenv"
require "httparty"
require "awesome_print"
require_relative "factory"
Dotenv.load

def main
  puts "Hello. Welcome, friend. Please enjoy our Slack CLI."
  puts "What would you like to do? Please select an option"
  puts "1. List Channels\n2. List Users\n3. Quit"
  user_selection = gets.chomp.downcase
  while user_selection
    case user_selection
    when "1" || "list channels"
      puts "list_channels"
    when "2" || "list users"
      puts "list_users"
      factory = Factory.new
      puts factory.list_users
    when "3" || "quit"
      puts "Thank you for using the Ada Slack CLI"
      exit
    end
    puts "What would you like to do? Please select an option"
    puts "1. List Channels\n2. List Users\n3. Quit"
    user_selection = gets.chomp.downcase
  end
end

main if __FILE__ == $PROGRAM_NAME
