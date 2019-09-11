require 'dotenv'
require 'httparty'
require_relative 'recipient'
require_relative 'channel'
require_relative 'user'
require_relative 'workspace'

Dotenv.load

# !/usr/bin/env ruby

# unless ENV['SLACK_TOKEN']
#   puts "Could not load API key, please store in the environment variable 'SLACK_TOKEN'"
#   exit
# end

def main
  puts "Welcome to the Ada Slack CLI!"
  
  
  
  puts "Thank you for using the Ada Slack CLI"
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
