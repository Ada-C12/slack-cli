require_relative "workspace"
require_relative "user"
require_relative "channel"
require_relative "acceptor"
require 'httparty'
require "dotenv"
Dotenv.load

def main
  
  puts "Welcome to the Ada Slack CLI!"
  workspace = Slack::Workspace.new
  workspace.user_list
  workspace.channel_list
  puts "Darn Cute Puppers has #{workspace.users.count} users and #{workspace.channels.count} channels."

  prompt = "Please select from the following options: 
  List Users
  List Channels
  Select Users
  Select Channels
  Show Details
  Quit"

  puts prompt
  
  while command = gets.chomp.downcase
    case command
    when "quit"
      exit
    when "list users"
      puts workspace.print_user_list
      break
    when "list channels"
      puts workspace.print_channel_list
      break
    when "select users" 
      puts "Please enter the username or slack id: "
      user_query_term = gets.chomp
      # TO-DO: how to handle username is downcase, slack id is upcase
      # search(user, user_query_term)
      # if @selected = nil, let customer know and return to main
      # if @selected !=nil , display details and message
      
      
      # completed: use the username/slack_id and iterate through a list of users in Workspace 
      # completed: saved user to @selected inside workspace

    when "select channels"
      # code
      # if user selects a channel, search for that channel,
      # if channel not found output a message to user and return to main menu
      # if channel found, display "do you want to see details or send message or go back to the main menu?"
      # if user selects either option, do that command,
      # exit program
      search (channel, name)
    when "show details"
      # code
    else
      puts "Error: Invalid selection. Returning to main menu...."
      puts prompt
    end
  end
  puts "Thank you for using the Ada Slack CLI"

end

main if __FILE__ == $PROGRAM_NAME

