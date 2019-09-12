#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'recipient'
require_relative 'user'
require_relative 'channel'
require "table_print"

Dotenv.load

def main
  
  puts "Welcome to the Ada Slack CLI!"
  menu_method
  
  selection = gets.chomp
  until selection == "5"
    selection_method(selection)
    puts "______________________________"
    menu_method
    selection = gets.chomp
  end
  
  puts "Thank you for using the Ada Slack CLI"
end

def menu_method
  menu_options = ["List Users in the Workspace", "List Channels in the Workspace", "Select User", "Select Channel", "Quit program"]
  menu_options.each_with_index do |prompt, i|
    puts " #{i + 1}. #{prompt}"
  end
end

def selection_method(selection)
  if selection == "1"
    tp SlackCLI::User.list
    # list channels
  elsif selection == "2"
    tp SlackCLI::Channel.list
    # select user
  elsif selection == "3" || selection == "4"
    find_username_or_slack_id(selection)
  end
end

def find_username_or_slack_id(selection)
  
  puts "Enter \"a\" to search by Username\nEnter \"b\"to search by Slack ID"
  find_by = gets.chomp
  puts "Enter search term:"
  name_or_id = gets.chomp
  
  if find_by == "a"
    if selection == "3"
      # this means they're looking for username
      SlackCLI::User.find(user_name: name_or_id)
    else 
      # looking for channel by channel name
      SlackCLI::Channel.find(name: name_or_id)
    end
    # search by user id or channel id
    # method - find by Name
  elsif find_by == "b"
    if selection == "3"
      SlackCLI::User.find(slack_id: name_or_id)
      # this means they're looking for username
    else 
      SlackCLI::Channel.find(slack_id: name_or_id)
      # looking for channel by channel name
    end
  end
end

main if __FILE__ == $PROGRAM_NAME

