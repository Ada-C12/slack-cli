require 'httparty'
require 'dotenv'

Dotenv.load

BASE_URL = "https://slack.com/api/channels.list"

query_parameters = {
  token: ENV['SLACK_API_TOKEN']
}

response = HTTParty.get(BASE_URL, query: query_parameters)

p response

# seven_wonders_locations = seven_wonders.map do |wonder|
#   # Code to discover the location of each wonders
#   query_parameters = {
#     key: ENV['LOCATION_IQ_KEY'],
#     q: wonder,
#     format: 'JSON'
#   }
# end