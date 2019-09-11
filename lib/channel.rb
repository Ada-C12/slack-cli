require 'dotenv'
require_relative 'recipient'

module Slack
  class Channel < Recipient 
    
    attr_reader :topic, :member_count
    
    def initialize(slack_id, name, topic, member_count)
      super(slack_id, name)
      @topic = topic
      @member_count = member_count
    end
    
    def details
    end
    
    def list
      url = "https://slack.com/api/channels.list"
      query_parameters = {
        token: ENV["SLACK_TOKEN"]
      }
      
      channel_objects = Recipient.get(url, query: query_parameters)
      
      channel_list = []
      channel_objects["channels"].each do |channel|
        channel_list << channel["name"]
      end
      
      return channel_list
      
    end
    
    
  end
end
