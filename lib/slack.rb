#!/usr/bin/env ruby
require_relative 'workspace'
require 'pry'
require 'table_print'

def main
  workspace = Workspace.new

  command_table = [{command: 'list users', description: 'lists all users in workspace'}, {command: 'list channels', description: 'lists all channels in workspace'}, {command: 'select user', description: 'selects a user'}, {command: 'select channel', description: 'selects a channel'}, {command: 'details', description: 'shows details of the current recipient'}, {command: 'send message', description: 'sends message to selected recipient'}]
  
  puts "Welcome to the Ada Slack CLI!\n\n"
  
  tp command_table
  puts "\n\nWhat would you like to do? Enter a command from the list above: "

  user_input = ""

  while user_input != "quit"
    user_input = gets.chomp

    case user_input
    when "list users"
      workspace.display_users

    when "list channels"
      workspace.display_channels

    when "select user"
      puts "Enter the name or slack id of the user: "
      user_input = gets.chomp
      if workspace.select_user(user_input) == []
        puts "Invalid entry! Please enter another user: "
        user_input = gets.chomp
      end

    when "select channel"
      puts "Enter the name or slack id of the channel: "
      user_input = gets.chomp
      if workspace.select_channel(user_input) == []
        puts "Invalid entry! Please enter another channel: "
        user_input = gets.chomp
      end

    when "details"
      if workspace.selected == nil
        puts "No recipient selected!"
        #user_input = gets.chomp
      else
        workspace.show_details
        puts "\n\n"
      end
      
    when "send message"
      if workspace.selected == nil
        puts "No recipient selected!"
      else
        puts "What do you want to send to #{workspace.selected[0].name}?"
        message = gets.chomp
        workspace.send_message(message)
      end

    when "quit"
      puts "Thank you for using the Ada Slack CLI!"
      exit
    end
    puts "Enter another command or type 'quit' to exit the program."
  end
end

main if __FILE__ == $PROGRAM_NAME