require "dotenv"
require "httparty"

Dotenv.load

url = "https://slack.com/api/channels.list"

query = { token: ENV["SLACK_API_TOKEN"] }

response = HTTParty.get(url, query: query)

response["channels"].each do |channel|
  puts channel["name"]
end
