require_relative 'recepient'
require 'dotenv'
Dotenv.load


CHANNELS_URL = "https://slack.com/api/channels.list"

module Slack
  class Channel
    attr_reader :name, :topic, :member_count, :slack_id
    CHANNELS_LIST = "https://slack.com/api/channels.list"
    
    def initialize(name, topic, member_count, slack_id)
      @name = name
      @topic = topic
      @member_count = member_count
      @slack_id = slack_id
    end
    
    def self.list_channels
      query = {
        token: ENV["SLACK_API_TOKEN"]
      }
      response = HTTParty.get(CHANNELS_LIST, query: query)
      channels = response["channels"]
      channels_list = []
      channels.each do |channel_hash|
        name = channel_hash["name"]
        topic = channel_hash["topic"]
        member_count = channel_hash["member_count"]
        slack_id = channel_hash["slack_id"]
        channels_list << Channel.new(name, topic, member_count, slack_id)
      end
      
      return channels_list 
    end 
  end
end





