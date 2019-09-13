require 'dotenv'
require 'httparty'
require_relative 'recipient'
require_relative 'channel'
require_relative 'user'
require_relative 'workspace'
require 'colorize'
require 'table_print'

Dotenv.load

# !/usr/bin/env ruby

# unless ENV['SLACK_TOKEN']
#   puts "Could not load API key, please store in the environment variable 'SLACK_TOKEN'"
#   exit
# end

def main
  workspace = SlackBot::Workspace.new
  valid_inputs = ["list users", "list channels", "select user", "select channel", "details", "send_message", "quit"]
  user_input = nil
  
  until valid_inputs.include?(user_input)
    puts "\nPlease make a selection:"
    puts "List Users"
    puts "List Channels"
    puts "Select User"
    puts "Select Channel"
    puts "Details"
    puts "Send Message"
    puts "Quit"
    print "Selection: "
    user_input = gets.chomp.downcase
    
    case user_input
    when "list users"
      tp workspace.users, "slack_id", "name", "real_name"
      user_input = nil
    when "list channels"
      tp workspace.channels, "slack_id", "name", "topic", "member_count"
      user_input = nil
    when "select user"
      print "Enter a Username or Slack ID: "
      user_criteria = gets.chomp
      workspace.select_user(user_criteria)
      user_input = nil
    when "select channel"
      print "Enter a Channel Name or Slack ID: "
      channel_criteria = gets.chomp
      workspace.select_channel(channel_criteria)
      user_input = nil
    when "details"
      if workspace.selected == nil
        puts "No user or channel has been selected.".colorize(:red)
        user_input = nil
      else
        workspace.show_details
        user_input = nil
      end
    when "send message"
      if workspace.selected == nil
        puts "No user or channel has been selected.".colorize(:red)
        user_input = nil
      else
        puts "What message you would like to send to #{workspace.selected.name}: "
        message = gets.chomp
        workspace.send_message(message: message)
        user_input = nil
      end
    when "quit"
      puts "\nThank you for using the Ada Slack CLI".colorize(:yellow)
      exit
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
