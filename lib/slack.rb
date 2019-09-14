#!/usr/bin/env ruby
require 'table_print'
require 'httparty'
require 'dotenv'

Dotenv.load

require_relative 'user'
require_relative 'channel'
require_relative 'recipient'
require_relative 'slack_api_error'
require_relative 'workspace'

VALID_INPUT = ["list users", "list channels", "select user", "select channel", "details", "send message", "quit"]

def list_options
  list_of_options = "\n~~MENU~~\n1. List Users\n2. List Channels\n3. Select User\n4. Select Channel\n5. Details\n6. Send message\n7. Quit\nWhich option would you like?"
  return list_of_options
end

def handle_bad_input(user_input)
  
  until VALID_INPUT.include? user_input
    puts "Error! Your input (#{user_input}) is invalid. Please choose one of the following options and try again."
    puts list_options
    user_input = gets.chomp.downcase
  end
  return user_input
end

def id_or_name(list, user_choice)
  list.each do |object|
    return "id" if user_choice == object.id  
    return "name" if user_choice == object.name
  end
end

def channel_or_user
  
end

def main
  current_workspace = Slack::Workspace.new
  
  channel_list = Slack::Channel.list
  user_list = Slack::User.list
  
  puts "Welcome to the Ada Slack CLI!"
  puts "#{channel_list.length} channels and #{user_list.length} users were loaded. What would you like to do?"
  
  puts list_options
  
  user_input = gets.chomp.downcase
  
  user_input = handle_bad_input(user_input)
  
  until user_input == "quit"
    case user_input
    when "list users"
      tp user_list, "id", "name", "real_name", "status_text", "status_emoji"
    when "list channels"
      tp channel_list, "id", "name", "topic", "member_count"
    when "select user"
      print "Which user would you like to select? Please provide the name or ID: "
      user_choice = gets.chomp
      type = id_or_name(user_list, user_choice)
      if type == "name"
        selected_user = current_workspace.select_user(username: user_choice)
        puts "Great! Your selected user is #{selected_user.name}."
      else
        begin
          selected_user = current_workspace.select_user(id: user_choice)
          puts "Great! Your selected user is #{selected_user.name}."
        rescue ArgumentError => message
          puts message
        end
      end
      
    when "select channel"
      print "Which channel would you like to select? Please provide the name or ID: "
      user_choice = gets.chomp
      
      type = id_or_name(channel_list, user_choice)
      if type == "name"
        selected_channel = current_workspace.select_channel(channel_name: user_choice)
        puts "Wonderful! Your selected channel is #{selected_channel.name}."
      else
        begin
          selected_channel = current_workspace.select_channel(id: user_choice)
          puts "Wonderful! Your selected channel is #{selected_channel.name}."
        rescue ArgumentError => message
          puts message
        end
      end
      
    when "details"
      details = current_workspace.show_details
      if current_workspace.selected.class == Slack::User
        tp [details], "username", "id", "real_name", "status_text", "status_emoji"
      else
        tp [details], "id", "name", "topic", "member_count"
      end
    when "send message"
      puts "What message would you like to send to #{current_workspace.selected.name}?"
      user_message = gets.chomp
      begin
        current_workspace.send_message(message: user_message)
      rescue Slack::Slack_Api_Error => message
        puts message
      end
    end
    
    puts list_options
    user_input = gets.chomp.downcase
    user_input = handle_bad_input(user_input)
  end
  
  # list three options for how to interact with the program: list users, list channels, quit
  
  # handle invalid input
  
  # list users - see a list of all users in the slack workspace. include username, real name, and slack id
  
  # list channels - list of all channels in the workspace. include channel name, topic, member count, slack id
  
  # quit - exit program
  
  # after completing other commands, reprint the list of commands and ask for another input
  
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME