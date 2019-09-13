#!/usr/bin/env ruby
require_relative 'workspace'
require 'pry'
def main
  workspace = Workspace.new
  
  puts "Welcome to the Ada Slack CLI!"
  
  
  puts "What would you like to do?"
#   tp [
#     {
#       command: 'list users',
#       description: 'list all users in workspace'
#     }
#   ]
#   tp [["command", "descriptions"],
#   ["list users", "list all users in workspace"],
#   ["list channels", "list all channels in workspace"],
#   ["select user", "select a user as the current recipient"],
#   ["select channel", "select a channel as the current recipient"],
#   ["details", "show details of the current recipient"]
# ]



user_input = ""
while user_input != "quit"
  user_input = gets.chomp

  if user_input == "list users"
    workspace.display_users
  elsif user_input == "list channels"
    workspace.display_channels
  elsif user_input == "select user"
    user_input = gets.chomp
    workspace.select_user(user_input)
 

  elsif user_input == "select channel"
    user_input = gets.chomp
    workspace.select_channel(user_input)
  elsif user_input == "details"
    tp workspace.selected
    # print details of workspace.selected
     
  elsif user_input == "quit"
    exit
  end

end


puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME