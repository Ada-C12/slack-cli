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
MAIN_MENU = ["List Users", "List Channels", "Quit"]

def print_users
  puts "\n"
  tp PUMPKIN_SPICE.users, "name", "real_name", "slack_id"
end

def print_channels
  puts "\n"
  tp PUMPKIN_SPICE.channels, "name", {"topic" => {:width => 60}}, "member_count", "slack_id"
end

def print_workplace_stats()
  user_count = PUMPKIN_SPICE.users.length
  channel_count = PUMPKIN_SPICE.channels.length
  puts "This workplace has #{user_count} users and #{channel_count} channels."
end

def print_menu()
  MAIN_MENU.each_with_index do |menu_item, index|
    puts "#{index + 1}. #{menu_item}"
  end
end

def main
  puts "Welcome to the Ada Slack CLI!\n\n"
  # lists number of users and channels
  print_workplace_stats()
  puts "\n"
  
  again = true
  while again
    # lists menu options
    print_menu()  
    print "\nWhat would you like to do: "
    answer = gets.chomp.downcase
    
    case answer
    when "list users", "1", "one"
      print_users()
      puts "\n"
    when  "list channels", "2", "two"
      print_channels()
      puts "\n"
    when "quit", "3", "three", "exit"
      again = false
    end
  end
  
  puts "\nThank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
