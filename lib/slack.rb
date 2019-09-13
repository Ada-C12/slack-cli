#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'table_print'

require_relative 'recipient'
require_relative 'channel'
require_relative 'user'
require_relative 'workspace'

# Tell dotenv to look for the .env file
Dotenv.load

def main
  new_workspace = Workspace.new(User.list, Channel.list)

  while true
    puts "Welcome to the Ada Slack CLI!"
    puts "Select an option: list users, list channels, select user, select channel, details or quit"
    option = gets.chomp

    until option == "list users" || option == "list channels" || option == "quit" || option == "select user" || option == "select channel" || option == "details"
      puts "Select a valid option: list users, list channels, select user, select channel, details or quit" 
      option = gets.chomp 
    end

    break if option.downcase == "quit"

    if option.downcase == "list users"
       tp User.list

    elsif option.downcase == "list channels"
      tp Channel.list
    
    elsif option.downcase == "select user"
      puts "Enter the username or Slack ID"
      selection = gets.chomp
      new_workspace.select_user(selection)

   elsif option.downcase == "select channel"
      puts "Enter the channel name or Slack ID"
      selection = gets.chomp
      new_workspace.select_channel(selection)

   elsif option.downcase == "details"
      if new_workspace.show_details == nil 
        puts "You haven't enter the name or Slack ID"
      end
      tp [new_workspace.show_details]
   end

  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME