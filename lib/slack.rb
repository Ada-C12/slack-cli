#!/usr/bin/env ruby
require_relative 'workspace'

def main
  workspace = Workspace.new

  puts "Welcome to the Ada Slack CLI!"

  puts "What would you like to do? 
  \n -list users 
  \n -list channels 
  \n quit"

  user_input = gets.chomp

  if user_input == "list users"
    workspace.display_users
  elsif user_input == "list channels"
    # returns details of each channel
  elsif user_input == "quit"
    exit
  end


  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME