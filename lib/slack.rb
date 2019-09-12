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
  Select User
  Select Channel
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
    when "select user" 
      puts "Would you like to search for a user by username or id?"
      search_user_choice = gets.chomp.downcase
      if search_user_choice == "username"
        puts "Please enter the username: "
        username = gets.chomp.downcase
        search_result = workspace.search("user", username)
        if search_result == nil
          puts "User not found. Returning to main menu..."
          puts prompt
        else
          puts "User found. Please select from the following options:
          Show Details
          Send Message"
          # take user input and call show_details 
          selected_command = gets.chomp.downcase
          if selected_command == "show details"
            puts workspace.show_details(search_result)
            break
          end
        end
      elsif search_user_choice == "id"
        puts "Please enter the slack id: "
        slack_id = gets.chomp.upcase
        search_result = workspace.search("user", slack_id)
        if search_result == nil
          puts "User not found. Returning to main menu..."
          puts prompt
        else
          puts "User found. Please select from the following options:
          Show Details
          Send Message"
        end
      else
        puts "Invalid input. Returnng to main menu..."
        puts prompt
      end
  
      # if @selected = nil, let customer know and return to main
      # if @selected !=nil , display details and message
      

      # when "select channel"
      #   # code
      #   # if user selects a channel, search for that channel,
      #   # if channel not found output a message to user and return to main menu
      #   # if channel found, display "do you want to see details or send message or go back to the main menu?"
      #   # if user selects either option, do that command,
      #   # exit program
      #   search (channel, name)
      # when "show details"
      #   # code
    else
      puts "Error: Invalid selection. Returning to main menu...."
      puts prompt
    end
  end
  puts "Thank you for using the Ada Slack CLI"

end

main if __FILE__ == $PROGRAM_NAME

