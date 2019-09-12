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
  
  puts "Welcome to the Ada Slack CLI!"
  print "Please choose an option: list users, list channels, or quit: "
  input = gets.chomp
  
  if input == "list users"
    tp workspace.users, :user_name, :real_name, :slack_id
  elsif input == "list channels"
    tp workspace.channels, :name, :topic, :member_count, :slack_id
  elsif input == "quit"
    exit
  end
  
  
  # list users = see a list of all users, including 
  # username, real name, and Slack ID (user.list)
  # list channels = see a list of all channels, # including name, topic, member coiunt, and Slack ID (channel.list)
  # quit = exit the program
  
  
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
