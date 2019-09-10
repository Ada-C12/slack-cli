#!/usr/bin/env ruby
require "dotenv"
require "httparty"
require "awesome_print"

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
    when "3" || "quit"
      exit
    end
    puts "What would you like to do? Please select an option"
    puts "1.List Channels\n 2. List Users\n 3.Quit"
    user_selection = gets.chomp.downcase
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
