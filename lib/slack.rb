#!/usr/bin/env ruby
# require 'dotenv'
# require 'httparty'
require 'awesome_print'
require_relative 'workspace'
require "table_print"

Dotenv.load

def main
  
  puts "Welcome to the Ada Slack CLI!"
  menu_method
  
  selection = gets.chomp
  until selection == "3"
    selection_method(selection)
    puts "______________________________"
    menu_method
    selection = gets.chomp
    learn_more_method
  end
  
  puts "Thank you for using the Ada Slack CLI"
end

def menu_method
  # menu_options = ["List Users in the Workspace", "List Channels in the Workspace", "Select User", "Select Channel", "Quit program"]
  menu_options = ["List Users in the Workspace", "List Channels in the Workspace", "Quit"]
  menu_options.each_with_index do |prompt, i|
    puts " #{i + 1}. #{prompt}"
  end
end


def selection_method(selection)
  workspace = SlackCLI::Workspace.new #Move Somewhere More Important
  if selection == "1"
    tp workspace.users
  elsif selection == "2"
    tp workspace.channels
  end
end


def learn_more_method(selection)
  # selection 1 is users
  # selection "2"  is channels
  puts "Enter \"a\" to search by Username\nEnter \"b\"to search by Slack ID"
  find_by = gets.chomp
  puts "Enter search term:"
  name_or_id = gets.chomp
  
  if find_by == "a"
    if selection == "1"
      # this means they're looking for username
      workspace.select_user(user_name: name_or_id)
    else 
      # looking for channel by channel name
      workspace.select_channel(name: name_or_id)
    end
    # search by user id or channel id
    # method - find by Name
  elsif find_by == "b"
    if selection == "1"
      workspace.select_user(slack_id: name_or_id)
      # looking for channel by channel name
    else 
      workspace.select_channel(slack_id: name_or_id)
      # this means they're looking for username
    end
  end
  # if looking for a channel / user and it doesn't exist- error mesasge or something & return to main command 
  
end

main if __FILE__ == $PROGRAM_NAME

