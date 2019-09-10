#!/usr/bin/env ruby
require "httparty"
require "dotenv"
Dotenv.load

BASE_URL = "https://slack.com/api/channels.list"
KEY = ENV["SLACK_API_TOKEN"]
def main
  query = {
  token: KEY
  }
  response = HTTParty.get(BASE_URL, query: query)
  #puts "Welcome to the Ada Slack CLI!"

  # TODO project
  return response
  #puts "Thank you for using the Ada Slack CLI"
end

puts main

main if __FILE__ == $PROGRAM_NAME