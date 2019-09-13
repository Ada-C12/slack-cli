require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load 

require_relative './channel'
require_relative 'user'

def start_program
  ap "Welcome to the Ada Slack CLI!"
  print "What would you like to do? Type one of the following:\n - list channels\n - list users\n - select user\n - select channel\n - details\n - send message\n - quit\n"
  user_input = gets.chomp.downcase


  while user_input != "quit"  
    case user_input 
    when "list channels"
      ap SlackCli::Channel.list
    when "list users"
      ap SlackCli::User.list 
    when "select user"
      ap "Type a username or Slack ID."
      search_user = gets.chomp
      selected_recipient = SlackCli::User.list.find do |i|
        i[:user_name]== search_user || i[:id] == search_user
      end
      if selected_recipient == nil 
        ap "User not found"
      else 
        selected_recipient = SlackCli::User.new(
          name: selected_recipient[:user_name],
          real_name: selected_recipient[:real_name],
          id: selected_recipient[:id]
        )
        ap "Recipient has been selected."
      end

    when "select channel"
      ap "Type a username or Slack ID."
      search_channel = gets.chomp
      selected_recipient = SlackCli::Channel.list.find do |i|
        i[:name]== search_channel || i[:id] == search_channel
      end
      if selected_recipient == nil 
        ap "Channel not found"
      else 
        selected_recipient = SlackCli::Channel.new(
          name: selected_recipient[:name],
          topic: selected_recipient[:topic],
          id: selected_recipient[:id],
          num_members: selected_recipient[:num_members]
        )
        ap "Recipient has been selected."
      end

    when "details"
      if selected_recipient.class == SlackCli::Channel
        ap "Channel name: #{selected_recipient.name}"
        ap "Channel topic: #{selected_recipient.topic}"
        ap "Channel id: #{selected_recipient.id}"
        ap "Channel members count: #{selected_recipient.num_members}"
      elsif selected_recipient.class == SlackCli::User 
        ap "Username: #{selected_recipient.name}"
        ap "User real name: #{selected_recipient.real_name}"
        ap "User id: #{selected_recipient.id}"
      else 
        ap "No recipient is currently selected. Select a recipient in the main menu."
      end 
       ap selected_recipient
    when "send message"
      if selected_recipient == nil 
        ap "No recipient selected."
      else 
        ap "Type a message to send:"
        message = gets.chomp
        SlackCli::Recipient.send_message(recipient:selected_recipient.id, message:message)
      end  
    else 
      ap "Not a valid command"
    end 
    print "What would you like to do? Type one of the following:\n - list channels\n - list users\n - select user\n - select channel\n - details\n - send message\n - quit\n"
    user_input = gets.chomp.downcase
  end 
  ap "Thank you for using the Sara & Monick Slack CLI."
end 
start_program