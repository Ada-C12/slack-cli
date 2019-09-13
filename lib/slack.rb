#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'awesome_print'
require_relative './user'
require_relative './channel'
Dotenv.load('../.env')

KEY = ENV['KEY']
#CHAT_URL = "https://slack.com/api/chat.postMessage"

def main
  recipient = nil
  users = Slack::User.list_users
  channels = Slack::Channel.list_channels
  
  # Wave 1 
  puts "Welcome to the Ada Slack CLI!"
  puts "There are #{users.length} users and #{channels.length} channels."
  
  # Loop
  while true
    puts "Would you like to view: List Users, List Channels, Select User, Select Channel, See Details, Send Message, or Quit?" 
    user_input = gets.chomp.split.map(&:capitalize).join(' ')
    case user_input 
    when "List Users"
      users.each do |user|
        puts "User count: #{users.length}, User Name: #{user.user_name}, Real name: #{user.name}, and Slack ID: #{user.slack_id}."
      end
    when "List Channels"
      channels.each do |channel|
        puts "Channel's name: #{channel.channel_name}, Member Count: #{channel.member_count}, and Slack ID: #{channel.slack_id}."
      end
    when "Send Message"
      recipient.each do |channel|
        puts "Channel's name: #{channel.channel_name}, Member Count: #{channel.member_count}, and Slack ID: #{channel.slack_id}."
      end
      
      # Wave 2: Selection Method
    when "Select User"
      puts "Please enter a username or slack id to continue."
      recipient_selection = gets.chomp
      recipient = Slack::User.select_user(recipient_selection)
      if recipient == nil
        puts "No username or slack id found. Returning you to main menu."
      end
      
    when "Select Channel"
      puts "Please enter a channel name or slack id to continue."
      recipient_selection = gets.chomp
      recipient = Slack::Channel.select_channel(recipient_selection)
      if recipient == nil
        puts "No channel name or slack id found. Returning you to main menu."
      end
      
    when "See Details"
      if recipient == nil # if no recipient is selected, no details can be shown
        puts "No recipient currently selected. Returning you to main menu."
      else 
        puts recipient.details # if recipient selected, show details
      end
      
      # Wave 3: Send Message to selected user
    when "Send Message"
      puts "Please enter your new message now."
      message_recipient = gets.chomp
      message_recipient = Slack::User.select_user(message_recipient)
      if recipient == nil 
        puts "No recipient currently selected. Returning you to main menu."
      end
      #   recipient.send_message(message) # user's message is sent to our Slack recipient 
      
    when "Quit"
      puts "Exiting program"
      quit
    else
      puts "Incorrect input."
    end
  end
  
  # Program ends and exits
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

