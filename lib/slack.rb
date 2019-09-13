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
    puts "Select an option: list users, list channels, select user, select channel, details, send message to channel, send message to user or quit"
    option = gets.chomp

    until option == "list users" || option == "list channels" || option == "quit" || option == "select user" || option == "select channel" || option == "details" || option == "send message to channel" || option == "send message to user"
      puts "Select a valid option: list users, list channels, select user, select channel, details, send message or quit" 
      option = gets.chomp.downcase
    end

    break if option == "quit"

    if option == "list users"
       tp User.list

    elsif option == "list channels"
      tp Channel.list
    
    elsif option == "select user"
      puts "Enter the username or Slack ID"
      selection = gets.chomp
      new_workspace.select_user(selection)

   elsif option == "select channel"
      puts "Enter the channel name or Slack ID"
      selection = gets.chomp
      new_workspace.select_channel(selection)

   elsif option == "details"
      if new_workspace.show_details == nil 
        puts "You haven't enter the name or Slack ID"
      end
      tp [new_workspace.show_details]
      
    elsif option == "send message to channel"
      puts "Please enter the channel name or Slack ID"
      selection = gets.chomp
      channel = new_workspace.select_channel(selection)
      puts "Please enter the message:"
      message = gets.chomp
      channel.send_message(message)

    elsif option == "send message to user"
      puts "Please enter the user name or Slack ID"
      selection = gets.chomp
      user = new_workspace.select_user(selection)
      puts "Please enter the message:"
      message = gets.chomp
      user.send_message(message)
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME