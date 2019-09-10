require 'dotenv'
require_relative 'recipient'

module Slack
  class Channel < Recipient 
    
    attr_reader :topic, :member_count
    
    def initialize(topic, member_count)
      super(slack_id, name)
      @topic = topic
      @member_count = member_count
    end
    
    def details
    end
    
    def list
      url = "https://slack.com/api/channels.list"
      
      KEY = ENV["SLACK_TOKEN"]
      query_parameters = {
        token: KEY
      }
      
      channel_objects = self.get(url, query: query_parameters)
      
      channel_list = []
      channel_objects["channels"].each do |channel|
        channel_list << channel["name"]
      end
      
      return channel_list
      
    end
    
    
  end
end
