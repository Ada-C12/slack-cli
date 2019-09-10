#!/usr/bin/env ruby

require 'dotenv'
require 'httparty'
require 'ap'
require_relative 'user'

Dotenv.load

CHANNELS_URL = "https://slack.com/api/channels.list"
USERS_URL = "https://slack.com/api/users.list" 

# module Slack
#   class Workspace
def main
  token = ENV['SLACK_TOKEN']
  
  users = Slack::User.get(USERS_URL, query: {token: token})
  
  ap users
  
end
#   end
# end

main if __FILE__ == $PROGRAM_NAME



# response = HTTParty.get(USERS_URL, query: {token: token})

# response["channels"].each do |channel|
#   ap channel["name"]
# end

# puts "Welcome to the Ada Slack CLI!"

# # TODO project

# puts "Thank you for using the Ada Slack CLI"