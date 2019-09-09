# channels_list documentation: https://api.slack.com/methods/channels.list
# users_list: https://api.slack.com/methods/users.list
# chat.postMessage: https://api.slack.com/methods/chat.postMessage
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
p response
# use HTTParty to send a GET request to the channels.list endpoint
# Check that the request completed successfully 
# If the request wasn't completed successfully, print relevant info to console
# Loop through results and print out name of each channel
# Both partners should be able to sucessfully run this script
