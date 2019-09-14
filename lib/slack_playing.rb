#!/usr/bin/env ruby
require 'awesome_print'
require 'httparty'
require 'dotenv'
Dotenv.load
# will raise error if key not found
Dotenv.require_keys("SLACK_KEY")
puts ENV["SLACK_KEY"]

# THESE ARE THE 3 THINGS WE'RE ALLOWED TO DO ON THIS API
# chat:write:bot
# channels:read
# users:read

def main
  puts "\nWelcome to the Ada Slack CLI!\n\n"

  url = "https://slack.com/api/channels.list"
  query_params = { token: ENV["SLACK_KEY"] }
  response = HTTParty.get(url, query: query_params)
  ap response
  puts
  url = "https://slack.com/api/users.list"
  query_params = { token: ENV["SLACK_KEY"] }
  response = HTTParty.get(url, query: query_params)
  ap response
  puts
  # url = "https://slack.com/api/chat.postMessage"
  # query_params = { token: ENV["SLACK_KEY"], channel: "CN5R2SQ8L", text: "CHECK THIS OUT!!!"}
  # response = HTTParty.get(url, query: query_params)
  # # ap response
  # puts

  
  url = "https://slack.com/api/chat.postEphemeral"
  query_params = { token: ENV["SLACK_KEY"], channel: "CN5R2SQ8L", text: "HI!!", user: "UN69JD3V3"}
  response = HTTParty.get(url, query: query_params)
  ap response
  puts




  puts "\nThank you for using the Ada Slack CLI\n\n"
end

main if __FILE__ == $PROGRAM_NAME