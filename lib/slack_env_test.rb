require 'httparty'
require 'dotenv'
require 'awesome_print'
Dotenv.load


url = "https://slack.com/api/channels.list"

KEY = ENV["SLACK_TOKEN"]
query_parameters = {
  token: KEY
}

channel_objects = HTTParty.get(url, query: query_parameters)

#ap response.class
# ["channels"][0]["name"]

# response["channels"].each do |object|
#   puts object["name"]
# end


p channel_objects["channels"]

# channel_list = []
# channel_objects["channels"].each do |channel|
#   channel_list << channel["name"]
# end

# puts channel_list