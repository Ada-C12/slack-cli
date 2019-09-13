require_relative "workspace"
require_relative "user"
require_relative "channel"
require 'httparty'
require "dotenv"
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!\n"
  workspace = Slack::Workspace.new
  workspace.user_list
  workspace.channel_list
  
  puts "\nDarn Cute Puppers has #{workspace.users.count} users and #{workspace.channels.count} channels.\n"

  prompt = "\nPlease select from the following options: 
  List Users
  List Channels
  Select User
  Select Channel
  Quit\n"

  puts prompt
  
  while command = gets.chomp.downcase
    case command
    when "quit"
      exit
    when "list users"
      puts workspace.print_user_list
      puts prompt
    when "list channels"
      puts workspace.print_channel_list
      puts prompt
    when "select user"
      puts "Please enter a username or Slack ID."
      username = gets.chomp.downcase
      search_result = workspace.search("user", username)
      if search_result == nil
        puts "User not found. Returning to main menu..."
        puts prompt
        break
      else
        puts "User found."
        options = "Please select from the following options:
        Show Details
        Send Message
        Main Menu"
        puts options
        while selected_command = gets.chomp.downcase
          case selected_command
          when "main menu"
            puts prompt
            break
          when "show details"
            puts workspace.show_details(search_result)
            puts options
          when "send message"
            puts "What message do you want to send?"
            message_body = gets.chomp
            convert_to_username = workspace.selected.username
            workspace.send_message(message_body, "@#{convert_to_username}")
            puts "Message sent. Returning to main menu..."
            puts prompt
            break
          else
            puts "Invalid input. Returning to main menu..."
            puts prompt
            break
          end
        end
      end
    when "select channel"
      puts "Please enter a channel name or Slack ID."
      channel_name = gets.chomp.downcase
      search_result = workspace.search("channel", channel_name)
      if search_result == nil
        puts "Channel not found. Returning to main menu..."
        puts prompt
        break
      else
        puts "Channel found."
        options = "Please select from the following options:
        Show Details
        Send Message
        Main Menu"
        puts options
        while selected_command = gets.chomp.downcase
          case selected_command
          when "main menu"
            puts prompt
            break
          when "show details"
            puts workspace.show_details(search_result)
            puts options
          when "send message"
            puts "What message do you want to send?"
            message_body = gets.chomp
            convert_to_channel_name = workspace.selected.channel_name
            workspace.send_message(message_body, convert_to_channel_name)
            puts "Message sent. Returning to main menu..."
            puts prompt
            break
          else
            puts "Invalid input. Returning to main menu..."
            puts prompt
            break
          end
        end
      end
    else
      puts "Invalid input. Returning to main menu..."
      break
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
