require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'recipient'
require_relative 'channel'
require 'table_print'

Dotenv.load

module SlackCLI
  class User < Recipient
    
    
    def self.list_users
      
      response = HTTParty.get("https://slack.com/api/users.list?token=#{ENV['SLACK_TOKEN']}")
      # array called members 
      # need "id" "name" and "real_name"
      array_of_users = []
      response["members"].each do |member|
        info_hash = {}
        info_hash["id"] = member["id"]
        info_hash["user_name"] = member["name"]
        info_hash["real_name"] = member ["profile"]["real_name"]
        array_of_users << info_hash
      end
      return array_of_users
    end
  end
end

tp SlackCLI::User.list_users

# # goal - list users in a workspace
# # generally - list channels in a workspace
# url = 'https://slack.com/api/channels.list'
# query_params = 
# # TODO project
# query_params = {
# token: ENV['SLACK_TOKEN']
# }
# array_of_channels = []
# response = HTTParty.get(url, params: query_params)
# response["channels"].each do |response|
#   hash_of_ids = {}
#   id = response["id"]
#   members = response["members"].length
#   topic = response["topic"]["value"]
#   name = response["name"]
#   hash_of_ids["id"] = id
#   hash_of_ids["members"] = members
#   hash_of_ids["topic"] = topic
#   hash_of_ids["name"] = name
#   array_of_channels << hash_of_ids
# end

