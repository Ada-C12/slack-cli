require "dotenv"
require "httparty"
require "table_print"

require_relative "recipient"
require_relative "user"
require_relative "channel"
require_relative "workspace"

# !/usr/bin/env ruby
Dotenv.load

def main
  
  workspace = Slack::Workspace.new 
  # check user input
  # valid_input = ["list users", "list channels", "quit"]
  
  # if valid_input.include?(input)
  # loop to give users options again after each selection
  
  puts "Welcome to the Ada Slack CLI!"
  print "Please choose an option: list users, list channels, select user, select channel, details, or quit: "
  input = gets.chomp
  
  if input == "list users"
    tp workspace.users, :user_name, :real_name, :slack_id
  elsif input == "list channels"
    tp workspace.channels, :name, :topic, :member_count, :slack_id
  elsif input == "select user"
    # supply a username or Slack ID, get back selected recipient. If no match, return to input loop
  elsif input == "select channel"
    # supply a channel name or Slack ID, get back selected recipient. If no match, return to input loop
  elsif input == "details"
    # the print out details for the currently selected recipient (info depends on whether recipient is channel or user). If no recipient selected, return to main command prompt.
  elsif input == "quit"
    exit
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
