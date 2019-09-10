require "httparty"
require "dotenv"
require "awesome_print"

Dotenv.load

url = "https://slack.com/api/channels.list"
query_parameters = {
  token: ENV["SLACK_TOKEN"],
}

# channel_names =
# puts query_parameters
response = HTTParty.get(url, query: query_parameters)

# Loops through the results and prints name of each channel
# response["channels"].each do |channel|
#   ap channel["name"]
# end
# ap response["channels"][1]["name"]

# response["channels"].each do |channel|
#   ap channel["members"].length
# end

response["channels"].each do |channel|
  ap channel
end
