require 'dotenv'
require 'httparty'

Dotenv.load

# !/usr/bin/env ruby

# unless ENV['SLACK_TOKEN']
#   puts "Could not load API key, please store in the environment variable 'SLACK_TOKEN'"
#   exit
# end

## Check to see if the unless statement needs a conditional.


URL = "https://slack.com/api/users.list"

response = HTTParty.get(URL, query: {token: ENV['SLACK_TOKEN']})

p response

# def main
#   puts "Welcome to the Ada Slack CLI!"

#   # TODO project

#   puts "Thank you for using the Ada Slack CLI"
# end

# main if __FILE__ == $PROGRAM_NAME



