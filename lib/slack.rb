require 'httparty'
require  'dotenv'

Dotenv.load

# !/usr/bin/env ruby

def main
url = "https://slack.com/api/channels.list"
key = ENV['SLACK_TOKEN']


response = HTTParty.get(url, query: {token: key})


  puts "Welcome to the Ada Slack CLI!"

  # TODO project

  puts "Thank you for using the Ada Slack CLI"
  puts response
end

main if __FILE__ == $PROGRAM_NAME