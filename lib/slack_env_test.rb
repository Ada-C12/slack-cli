
require 'dotenv'
Dotenv.load
require 'awesome_print'
require 'httparty'
require_relative 'user'


url = "https://slack.com/api/users.list"
query_parameters = {
  token: ENV["SLACK_TOKEN"]
}
user_objects = HTTParty.get(url, query: query_parameters)

user = Slack::User.new("UMTG0S5D0", "samantha.collares", "Samantha Collares")

user_list = user.list 
p user_list.length

# user_objects["members"].each do |member|
#   p "The id is: #{member["id"]}"
#   p "The name is: #{member["name"]}"
# end

# p user_objects
# p user_objects.class
# p user_objects["members"][1]["id"]
# p user_objects["members"][1]["real_name"]
# p user_objects["members"][1]["name"]
# p 

# user_list = []
# user_objects["members"].each do |user|
#   user_list << member["name"]["real_name"]
# end
# return user_list



# url = "https://slack.com/api/channels.list"

# KEY = ENV["SLACK_TOKEN"]
# query_parameters = {
#   token: KEY
# }



# channel_objects = HTTParty.get(url, query: query_parameters)
# p channel_objects.class

#ap response.class
# ["channels"][0]["name"]

# response["channels"].each do |object|
#   puts object["name"]
# end


#p channel_objects["channels"]

# channel_list = []
# channel_objects["channels"].each do |channel|
#   channel_list << channel["name"]
# end

# puts channel_list