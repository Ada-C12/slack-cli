#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'awesome_print'
require_relative './user'
require_relative './channel'
Dotenv.load('../.env')

KEY = ENV['KEY']

# CHANNELS_URL = "https://slack.com/api/channels.list"
#  USERS_LIST = "https://slack.com/api/users.list"
#CHAT_URL = "https://slack.com/api/chat.postMessage"

def main
  users = Slack::User.list_users
  channels = Slack::Channel.list_channels
  puts "Welcome to the Ada Slack CLI!"
  puts "There are #{users.length} users and #{channels.length} channels."
  
  while true
    puts "Would you like to view: List Users, List Channels, or Quit?" 
    user_input = gets.chomp.split.map(&:capitalize).join(' ')
    case user_input 
    when "List Users"
      users = Slack::User.list_users
      users.each do |user|
        puts "User count: #{users.length}, User Name: #{user.user_name}, Real name: #{user.name}, and Slack ID: #{user.slack_id}."
      end
    when "List Channels"
      puts "Channel's name: #{channel}, Topic: #{topic}, Member Count: #{member count}, and Slack ID: #{slack_id}."
    when "Quit"
      puts "Exiting program"
      quit
    else
      puts "Incorrect input."
    end
  end
  
  # Wave 2: additional options 
  puts "Please select user."
  # by entering username or slack ID
  if user_input == user_name || slack_id
    # go to next step
    # if no user/channel exists with selection, return to initial options list
  elsif user_input != user_name || slack_id
    puts "Please select user."
    
    puts "Please select channel."
    # by entering channel name or slack ID
    if user_input == channel || slack_id
      # go to next step
      
      puts "Here are the details of your selection."
      # if user_input is not vaild, reprint list options
      
      # if user_input == channel
      # puts #{channel_name} or #{slack ID}
      
      # if user_input == user
      # puts user_name || slack_id
      
      # if no selected recepient, return to initial options
      
      
      puts "Thank you for using the Ada Slack CLI"
    end
  end
end

# wave 3 
# when recepient selected: type out message 
main if __FILE__ == $PROGRAM_NAME

