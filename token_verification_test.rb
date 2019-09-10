require 'dotenv' 
require 'httparty'

Dotenv.load

unless ENV['SLACK_TOKEN']
  puts "Could not load API key, please store in the environment variable 'SLACK_TOKEN'"
  exit
end 

URL = "https://slack.com/api/channels.list"

query_parameters = {
  token: ENV['SLACK_TOKEN']
}

response = HTTParty.get(URL, query: query_parameters)

if response['ok'] == false
    puts "Something went wrong: #{response['error']}"
else
  response["channels"].each do |channel|
    p "Channel: #{channel["name"]}"
  end
end