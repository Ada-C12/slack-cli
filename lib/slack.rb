require "dotenv"
require "httparty"

Dotenv.load

#!/usr/bin/env ruby

# def main
#   puts "Welcome to the Ada Slack CLI!"

#   # TODO project

#   puts "Thank you for using the Ada Slack CLI"
# end

# main if __FILE__ == $PROGRAM_NAME

# Accessing my workspace
URL = "https://slack.com/api/users.list"
response = HTTParty.get(URL, query: {token: ENV['SLACK_API_TOKEN']})
#p response
