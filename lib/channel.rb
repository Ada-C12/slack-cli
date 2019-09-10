require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load 

require_relative 'server'

module SlackCli
  class Channel < Server
    attr_reader :topic

    def initialize(topic:)
      @topic = topic
    end 

    def self.list
      method_url = "https://slack.com/api/channels.list"
      query_params = {
        token: ENV["SLACK_TOKEN"]
      }
      response = HTTParty.get(method_url, query: query_params)
    
      channels = response.parsed_response["channels"]
      i = 0 
      channels.each do |channel|
        name = response.parsed_response["channels"][i]["name"]
        topic = response.parsed_response["channels"][i]["topic"]
        id = response.parsed_response["channels"][i]["id"]
        member_count = response.parsed_response["channels"][i]["member_count"]
        user_hash[:user_name] = user_name
        user_hash[:real_name] = real_name
        user_hash[:id] = id
        all_slack_users.push(user_hash)
        i += 1
        i += 1
      end 
    end 

  end 
end 