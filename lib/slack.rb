#!/usr/bin/env ruby
require 'awesome_print'
require_relative 'workspace'
require "table_print"

Dotenv.load
@workspace = SlackCLI::Workspace.new
def main
  puts "Welcome to the Ada Slack CLI!"
  menu_method
  selection = gets.chomp
  
  while selection == "1" || selection == "2"
    print_table(selection)
    learn_more_method(selection)
    message_menu
    menu_method
    selection = gets.chomp
  end
  
  puts "Thank you for using the Ada Slack CLI"
end

def menu_method
  # menu_options = ["List Users in the Workspace", "List Channels in the Workspace", "Select User", "Select Channel", "Quit program"]
  menu_options = ["List Users in the Workspace", "List Channels in the Workspace"]
  menu_options.each_with_index do |prompt, i|
    puts " #{i + 1}. #{prompt}"
  end
  puts "[Any Other Key] to Quit"
end


def print_table(selection)
  # determines whether you are going to print users or channels
  #Move Somewhere More Important
  if selection == "1"
    tp @workspace.users
  elsif selection == "2"
    tp @workspace.channels
  end
end

# show details
# @workspace.show_details

def learn_more_method(selection)
  # selection "1" is users
  # selection "2"  is channels
  puts "Enter \"a\" to search by Name\nEnter \"b\" to search by Slack ID\n[Any Other Key] to Quit"
  find_by = gets.chomp
  
  if find_by == "a"
    puts "Enter search term:"
    name_or_id = gets.chomp
    begin
      if selection == "1"
        # this means they're looking for username
        @workspace.select_user(user_name: name_or_id)
      else 
        # looking for channel by channel name
        @workspace.select_channel(name: name_or_id)
      end
    rescue 
      puts "NOT FOUND"
    end
    
  elsif find_by == "b"
    puts "Enter search term:"
    name_or_id = gets.chomp
    begin
      if selection == "1"
        @workspace.select_user(slack_id: name_or_id)
        # looking for channel by channel name
      else 
        @workspace.select_channel(slack_id: name_or_id)
        # this means they're looking for username
      end
    rescue 
      puts "NOT FOUND"
    end 
  else
    puts "Invalid menu selection"   
  end
end

def message_menu
  puts "Enter \"a\" to Show Details\nEnter \"b\" to Send Message\n[Any Other Key] to Quit"
  message_choice = gets.chomp
  if message_choice == "a"
    @workspace.show_details
  elsif message_choice == "b"
    # begin
    puts "Enter Message: "
    message = gets.chomp
    @workspace.send_message(message)
    # rescue
    # puts "Message Unable to Send"
    # end
  else
    puts "Invalid Menu Choice"
  end
end

main if __FILE__ == $PROGRAM_NAME

