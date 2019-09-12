require 'dotenv'
require 'httparty'
require_relative 'recipient'
require_relative 'channel'
require_relative 'user'
require_relative 'workspace'
require 'colorize'
require 'table_print'

Dotenv.load

# !/usr/bin/env ruby

# unless ENV['SLACK_TOKEN']
#   puts "Could not load API key, please store in the environment variable 'SLACK_TOKEN'"
#   exit
# end

def main
  workspace = SlackBot::Workspace.new
  selected = workspace.selected
  valid_inputs = ["list users", "list channels", "select user", "select channel", "quit"]
  user_input = nil
  
  until valid_inputs.include?(user_input)
    puts "\nPlease make a selection:"
    puts "List Users"
    puts "List Channels"
    puts "Select User"
    puts "Select Channel"
    puts "Quit"
    print "Selection: "
    user_input = gets.chomp.downcase
    
    case user_input
    when "list users"
      tp workspace.users, "slack_id", "name", "real_name"
      user_input = nil
    when "list channels"
      tp workspace.channels, "slack_id", "name", "topic", "member_count"
      user_input = nil
    when "select user"
      print "Enter a Username or Slack ID: "
      user_criteria = gets.chomp
      workspace.select_user(user_criteria)
      user_input = nil
    when "select channel"
      print "Enter a Channel Name or Slack ID: "
      channel_criteria = gets.chomp
      workspace.select_channel(channel_criteria)
      user_input = nil
    when "quit"
      puts "Thank you for using the Ada Slack CLI"
      exit
    end
  end
end

main if __FILE__ == $PROGRAM_NAME


## Hallie's Code:
# FOR List USERS:
# URL_USERS = "https://slack.com/api/users.list"

# response = HTTParty.get(URL_USERS, query: {token: ENV['SLACK_TOKEN']})

# users = []

# response["members"].each do |person|
#   user_hash = {}
#   user_hash[:user_name] = person["name"]
#   user_hash[:real_name] = person["real_name"]
#   user_hash[:slack_id] = person["id"]

#   users << user_hash
# end

# p users

# FOR List CHANNELS:
# URL_CHANNELS = "https://slack.com/api/conversations.list"

# response = HTTParty.get(URL_CHANNELS, query: {token: ENV['SLACK_TOKEN']})

# channels = []

# response["channels"].each do |channel|
#   channel_hash = {}
#   channel_hash[:channel_name] = channel["name"]
#   channel_hash[:topic] = channel["topic"]["value"]
#   channel_hash[:member_count] = channel["num_members"]
#   channel_hash[:slack_id] = channel["id"]

#   channels << channel_hash
# end

# p channels
