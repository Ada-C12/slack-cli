#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'

# Tell dotenv to look for the .env file
Dotenv.load

URL =	"https://slack.com/api/channels.list"
KEY = ENV['SLACK_TOKEN']

def main
  puts "Welcome to the Ada Slack CLI!"

  response = HTTParty.get(URL, query: {
    token: KEY
  })

  response["channels"].each do |channel|
    puts channel["name"]
  end

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME