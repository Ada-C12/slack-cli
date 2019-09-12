#!/usr/bin/env ruby
require "dotenv"
require "httparty"
require 'table_print'
require_relative "recipient"
require_relative "user"
require_relative "workspace"
require_relative "channel"

Dotenv.load

PUMPKIN_SPICE = SlackCLI::Workspace.new()

MAIN_MENU = ["List Users", "List Channels", "Select User", "Select Channel", "Details", "Send Message", "Change Bot Settings", "Quit"]

def print_workplace_stats()
  puts PUMPKIN_SPICE.get_workplace_stats()
end

def print_menu()
  puts "\nMAIN MENU"
  MAIN_MENU.each_with_index do |menu_item, index|
    puts "#{index + 1}. #{menu_item}"
  end
  puts "\n"
end

def print_users
  puts "\n"
  tp PUMPKIN_SPICE.users, "name", "real_name", "slack_id"
end

def print_channels
  puts "\n"
  tp PUMPKIN_SPICE.channels, "name", {"topic" => {:width => 60}}, "member_count", "slack_id"
end

def select_user
  print "Please enter the name or Slack ID of the user you want to select: "
  search_term = gets.chomp
  
  result = PUMPKIN_SPICE.find_user(search_term)
  
  puts
  if result
    puts "The user #{result.name} was found and selected."
  else
    puts "No user was found."
  end
end

def select_channel
  print "Please enter the name or Slack ID of the channel you want to select: "
  search_term = gets.chomp
  
  result = PUMPKIN_SPICE.find_channel(search_term)
  
  puts
  if result
    puts "The channel #{result.name} was found and selected."
  else
    puts "No channel was found."
  end
end

def print_details()
  puts
  if selected.class == SlackCLI::User
    tp selected, "name", "real_name", "slack_id"
  elsif selected.class == SlackCLI::Channel
    tp selected, "name", {"topic" => {:width => 60}}, "member_count", "slack_id"
  else
    puts "There is no recipient selected."
  end
end

def get_message()
  puts
  if PUMPKIN_SPICE.selected
    print "Please enter a message: "
    message = gets.chomp
    
    PUMPKIN_SPICE.send_message(message)
  else
    # puts
    puts "You need to select a recipient."
  end
end

def main
  puts "Welcome to the Ada Slack CLI!"
  puts
  # lists number of users and channels
  print_workplace_stats()
  
  again = true
  while again
    # lists menu options
    print_menu()  
    print "What would you like to do? "
      answer = gets.chomp.downcase
      
      case answer
      when "list users", "1", "one"
        print_users
        
      when  "list channels", "2", "two"
        print_channels
        
      when "select user", "3", "three"
        select_user
        
      when "select channel", "4", "four"
        select_channel
        
      when "details", "5", "five"
        print_details
        
      when "send message", "6", "six"
        get_message
        
      when "change bot settings", "7", "seven"
        print "Please enter the bot's new name: "
        name = gets.chomp
        PUMPKIN_SPICE.bot_name = name
        puts "The bot's new name is #{name}!"
        
        print "Please enter the bot's new avatar: "
        avatar = gets.chomp
        PUMPKIN_SPICE.bot_avatar = avatar
        puts "The bot's new avatar is #{avatar}!"
        
      when "quit", "8", "eight", "exit"
        PUMPKIN_SPICE.save_settings
        again = false
      end
    end
    puts "\nThank you for using the Ada Slack CLI"
  end
  
  main if __FILE__ == $PROGRAM_NAME
  