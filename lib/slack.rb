#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'table_print'

require_relative 'recipient'
require_relative 'channel'
require_relative 'user'

# Tell dotenv to look for the .env file
Dotenv.load

def main
  while true
    puts "Welcome to the Ada Slack CLI!"
    puts "Select an option: list users, list channels or quit"
    option = gets.chomp

    until option == "list users" || option == "list channels" || option == "quit"
      puts "Select a valid option: list users, list channels or quit"
      option = gets.chomp 
    end

    break if option.downcase == 'quit'

    if option.downcase == 'list users'
       tp User.list

    elsif option.downcase == 'list channels'
      tp Channel.list
    end

    puts "Select an option: select user, select channel, details"
    selection = gets.chomp

    until selection == "select user" || selection == "select channel" || selection == "select details"
      puts "Select a valid option: select user, select channel or select details"
      selection = gets.chomp 
    end


  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME