require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load 

require_relative './channel'
require_relative 'user'

#CONTROLLER-WIDE ISSUE - FOR SOME REASON, USER/CHANNEL LIST GETS PRINTED WHEN NOT CALLED ON

def start_program
  ap "Welcome to the Ada Slack CLI!"
  print "What would you like to do? Type one of the following:\n list channels\n list users\n select user\n select channel\n details\n quit\n"
  user_input = gets.chomp.downcase
  while user_input != "quit"  
    case user_input 
    when "list channels"
      SlackCli::Channel.list
    when "list users"
      SlackCli::User.list 
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
    when "details"
      if selected_recipient.class == SlackCli::Channel
        ap "Your selected recipient details:"
        ap selected_recipient.name
        ap selected_recipient.topic
        ap selected_recipient.id
        ap selected_recipient.num_members
      elsif selected_recipient.class == SlackCli::User 
        ap "Your selected recipient details:"
        ap selected_recipient.name
        ap selected_recipient.real_name
        ap selected_recipient.id
        # RIGHT NOW THIS ALSO PRINTS THE INSTANCE AFTER THE DETAILS
      else 
        ap "No recipient is currently selected. Select a recipient in the main menu."
      end 
       ap selected_recipient
    else 
      ap "Not a valid command"
    end 
    print "\nWhat would you like to do? Type one of the following:\n list channels\n list users\n select user\n select channel\n details\n quit\n"
    user_input = gets.chomp.downcase
  end 
  ap "Thank you for using the Sara & Monick Slack CLI."
end 
start_program