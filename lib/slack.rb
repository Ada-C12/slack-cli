#!/usr/bin/env ruby
require_relative "user"
require_relative "channel"
require_relative 'workspace'
require 'dotenv'
Dotenv.load
# require_relative "channel"

def main
  workspace = Slack::Workspace.new
  user_choice = nil
  until user_choice == "quit"
    puts "Welcome to the Ada Slack CLI!"
    
    user_choice = prompt(
      "What would you like to do?",
      ["List users", "List channels"]
    )
    
    if user_choice == "1"
      list = Slack::User.list
      
      list.each do |member_object|
        puts "slack id: #{member_object.slack_id}"
        puts "name: #{member_object.name}"
        puts "real name: #{member_object.real_name}\n"
      end
      
      search_choice = prompt(
        "Do you want to find a user by:", 
        ["Slack id", "User name"]
      )
      
      if search_choice == "1"
        puts "please enter that person's slack id: "
        slack_id = gets.chomp
        workspace.select_user_slack_id(slack_id: slack_id)
      elsif search_choice == "2"
        puts "please enter that person's user_name: "
        user_name = gets.chomp
        workspace.select_user_username(user_name: user_name)
      end
      
      communication_choice = prompt(
        "Do you want to:",
        ["See this user's details", "Send them a message?"]
      )
      
      if communication_choice == "1"
        workspace.show_details
      elsif communication_choice == "2"
        puts "Please enter a message: "
        message = gets.chomp
        workspace.send_message(message)
      end
      
    elsif  user_choice == "2"
      list = Slack::Channel.list
      
      list.each do |member_object|
        puts "slack id: #{member_object.slack_id}"
        puts "name: #{member_object.name}"
        puts "topic: #{member_object.topic}"
        puts "member_count: #{member_object.members}"
      end
      
      search_choice = prompt(
        "Do you want to find a channel by:", 
        ["Slack id", "Channel name"]
      )
      
      if search_choice == "1"
        puts "please enter that channel's slack id: "
        slack_id = gets.chomp
        workspace.select_channel_slack_id(slack_id: slack_id)
      elsif search_choice == "2"
        puts "please enter the name of that channel: "
        user_name = gets.chomp
        workspace.select_channel_username(user_name: user_name)
      end
      
      communication_choice = prompt(
        "Do you want to:",
        ["See this channel's details", "Send a message to the channel?"]
      )
      
      if communication_choice == "1"
        workspace.show_details
      elsif communication_choice == "2"
        puts "Please enter a message: "
        message = gets.chomp
        workspace.send_message(message)
      end
      
      
      puts "Thank you for using the Ada Slack CLI"
    end
  end
  
end

def prompt(message, options)
  puts message
  options.each_with_index do |option, index|
    puts "#{index + 1}. #{option}"
  end
  input = gets.chomp
end



main



main if __FILE__ == $SLACK