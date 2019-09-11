require 'dotenv'
require "httparty"
require 'pry'

Dotenv.load

# binding.pry

unless ENV["SLACK_API_TOKEN"]
  puts "API error."
  exit
end 

url = "https://slack.com/api/channels.list"

query_parameters = {
  token: ENV["SLACK_API_TOKEN"],
}

response = HTTParty.get(url, query: query_parameters)
#p response

if response["ok"] == false
  puts "Error."
else
  response["channels"].each do |channel|
    pp "Channel: #{channel["name"]}"
  end
end
