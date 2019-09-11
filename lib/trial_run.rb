require 'httparty'
require 'dotenv'

Dotenv.load

# 	https://slack.com/api/conversations.list includes private conversations
CHANNELS_BASE_URL = 	"https://slack.com/api/channels.list"
query_parameters = {
  token: ENV['SLACK_KEY']
}

channels_response = HTTParty.get(CHANNELS_BASE_URL, query: query_parameters)
channels_response["channels"].each do |channel|
  puts "channel id: #{channel["id"]}"
  puts "member: #{channel["members"]}"
  puts "name: #{channel["name"]}"
  puts "name normalized: #{channel["name_normalized"]}" 
end


# USERS_BASE_URL = "https://slack.com/api/users.list"
# query_parameters = {
#   token: ENV['SLACK_KEY']
# }

# users_response = HTTParty.get(USERS_BASE_URL, query: query_parameters)
# puts users_response

# CHAT_POST_BASE_URL = "https://slack.com/api/chat.postMessage"
# query_parameters = {
#   token: ENV['SLACK_KEY']
#   channel:
#   text:
# }