require 'httparty'
require 'dotenv'
require 'table_print'

Dotenv.load

# 	https://slack.com/api/conversations.list includes private conversations
# CHANNELS_BASE_URL = 	"https://slack.com/api/channels.list"
# query_parameters = {
#   token: ENV['SLACK_KEY']
# }

# channels_response = HTTParty.get(CHANNELS_BASE_URL, query: query_parameters)
# channels_selected_info = []
# channels_response["channels"].each do |channel|
#   channels_selected_info << [channel["id"], channel["members"], channel["name"], channel["name_normalized"]]
# end
# tp channels_selected_info, "channels", "members", "name", "name normalized"

USERS_BASE_URL = "https://slack.com/api/users.list"
query_parameters = {
  token: ENV['SLACK_KEY']
}

users_response = HTTParty.get(USERS_BASE_URL, query: query_parameters)
user_array = []
users_response["members"].each do |user|
  user_array << user["profile"]["real_name"]
  user_array << user["profile"]["display_name"]
end
  tp user_array, "real name", "display name"




# CHAT_POST_BASE_URL = "https://slack.com/api/chat.postMessage"
# query_parameters = {
#   token: ENV['SLACK_KEY']
#   channel:
#   text:
# }