#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'awesome_print'

Dotenv.load

URL = "https://slack.com/api/conversations.list"
KEY = ENV['SLACK_API_TOKEN']

def main
  
  query_param = {
    token: KEY
  }
  puts "Welcome to the Ada Slack CLI!"
  
  # TODO project
  response = HTTParty.get(URL, query: query_param)
  puts response
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME