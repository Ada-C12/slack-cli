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
          selected_command = gets.chomp.downcase
          if selected_command == "show details"
            puts workspace.show_details(search_result)
            break
          end
        end
      else
        puts "Invalid input. Returning to main menu..."
        puts prompt
      end
    when "select channel"
      puts "Would you like to search for a channel by channel name or id?"
      search_channel_choice = gets.chomp.downcase
      if search_channel_choice == "channel name"
        puts "Please enter the channel name: "
        channel_name = gets.chomp.downcase
        search_result = workspace.search("channel", channel_name)
        if search_result == nil
          puts "Channel not found. Returning to main menu..."
          puts prompt
        else
          puts "Channel found. Please select from the following options:
          Show Details
          Send Message"
          selected_command = gets.chomp.downcase
          if selected_command == "show details"
            puts workspace.show_details(search_result)
            break
          elsif selected_command == "send message"
            puts "What message do you want to send?"
            message_body = gets.chomp
            workspace.send_message(message_body, channel_name)
            break
          end
        end
      elsif search_channel_choice == "id"
        puts "Please enter the channel's slack id: "
        slack_id = gets.chomp.upcase
        search_result = workspace.search("channel", slack_id)
        if search_result == nil
          puts "Channel not found. Returning to main menu..."
          puts prompt
        else
          puts "Channel found. Please select from the following options:
          Show Details
          Send Message"
          selected_command = gets.chomp.downcase
          if selected_command == "show details"
            puts workspace.show_details(search_result)
            break
          elsif selected_command == "send message"
            puts "What message do you want to send?"
            message_body = gets.chomp
            workspace.send_message(message_body, slack_id)
            break
          end
        end
      else
        puts "Invalid input. Returning to main menu..."
        puts prompt
      end
    else
      puts "Error: Invalid selection. Returning to main menu...."
      puts prompt
    end
  end
  puts "Thank you for using the Ada Slack CLI"

end

main if __FILE__ == $PROGRAM_NAME