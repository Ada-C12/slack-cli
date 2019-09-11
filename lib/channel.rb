require_relative "../lib/recipient"
require "httparty"
require 'pry'

module Slack
  class Channel < Recipient
    attr_reader :topic, :member_count
    
    def initialize(slack_id, name, topic = nil, member_count)
      super(slack_id, name)
      @topic = topic
      @member_count = member_count
    end
    
    # def details
    # end
    
    def self.list
      #CHANNEL
      # URL_CLASSES = "https://slack.com/api/conversations.list"
      # response = HTTParty.get(URL_CLASSES, query: {token: ENV['SLACK_API_TOKEN']})
      # p response
      reponse = Channel.get("https://slack.com/api/conversations.list")
      
      channels = []
      response["channels"].each do |channel|
        
        channel_hash = {}
        channel_hash[:channel_name] = channel["name"]
        channel_hash[:topic] = channel["topic"]["value"]
        channel_hash[:member_count] = channel["num_members"]
        channel_hash[:slack_id] = channel["id"]
        
        channels << channel_hash
      end
      return channels
      #p channels
    end 
  end
end 
