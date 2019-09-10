#!/usr/bin/env ruby

require 'dotenv'
require 'httparty'

Dotenv.load

KEY = ENV["SLACK_API_KEY"]
URL = "https://slack.com/api/conversations.list"

def main
  puts "Welcome to the Ada Slack CLI!"

  # TODO project

  query_params = {
    token: KEY,
  }

  response = HTTParty.get URL, query: query_params
  puts response

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
