require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load 

require_relative 'recipient'

module SlackCli
  class Channel < Recipient
    attr_reader :name, :topic, :id, :num_members

    def initialize(name:, id:, topic:, num_members:)
      @name = name
      @id = id
      @topic = topic
      @num_members = num_members
    end 

    def list
      method_url = "https://slack.com/api/channels.list"
      query_params = {
        token: ENV["SLACK_TOKEN"]
      }
      response = HTTParty.get(method_url, query: query_params)
      
      channels = response.parsed_response["channels"]
      i = 0 
      all_channels = []
      channels.each do |channel|
        channel_hash = {}
        name = response.parsed_response["channels"][i]["name"]
        topic = response.parsed_response["channels"][i]["topic"]["value"]
        id = response.parsed_response["channels"][i]["id"]
        num_members = response.parsed_response["channels"][i]["num_members"]
        channel_hash[:name] = name
        channel_hash[:topic] = topic
        channel_hash[:id] = id
        channel_hash[:num_members] = num_members
        all_channels.push(channel_hash)
        i += 1
      end 
      ap all_channels
    end 

  end 
end 