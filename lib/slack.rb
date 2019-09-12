#!/usr/bin/env ruby
require "dotenv"
require "httparty"
require "vcr"
require "awesome_print"
require_relative "workspace"
Dotenv.load

def main
  workspace = Workspace.new
  puts workspace.get_channels
  puts "Hello. Welcome, friend. Please enjoy our Slack CLI."
  puts "What would you like to do? Please select an option"
  puts "1. List Channels\n2. List Users\n3. Select Channel\n4. Select User\n5. List Details\n6. Send Message\n7. Quit"
  user_selection = gets.chomp.downcase
  while user_selection
    case user_selection
    when "1" || "list channels"
      puts "list_channels"
      puts workspace.list_channels
    when "2" || "list users"
      puts "list_users"
      puts workspace.list_users
    when "3" || "select channel"
      puts "select_channel"
      selection = gets.chomp
      # make a method to validate that the input is a channel?
      
      puts workspace.find_by_id_or_name(workspace.channels, selection)
    when "4" || "select user"
      puts "select_user"
      selection = gets.chomp
      # make a method to validate that the input is a user?
      
      puts workspace.find_by_id_or_name(workspace.users, selection)
    when "5" || "details"
      puts "list_details_on_current_recipient"
      workspace.list_details_on_current_recipient
    when "6" || "send message"
      puts "send_message"
      puts "Do you want cats with that? (yes/no)"
      cats = gets.chomp.downcase
      puts "Please enter your message:"
      message = gets.chomp
      puts workspace.send_message(message, cats)      
    when "7" || "quit"
      puts "Thank you for using the Ada Slack CLI"
      exit
    end
    puts "What would you like to do? Please select an option"
    puts "1. List Channels\n2. List Users\n3. Select Channel\n4. Select User\n5. List Details\n6. Send Message\n7. Quit"
    user_selection = gets.chomp.downcase
  end
end

main if __FILE__ == $PROGRAM_NAME
