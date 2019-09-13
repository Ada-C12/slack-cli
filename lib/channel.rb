require 'dotenv'
require_relative 'recipient'

module Slack
  class Channel < Recipient 
    attr_reader :topic, :members
    
    def initialize(slack_id, name, topic, members)
      super(slack_id, name)
      @topic = topic
      @members = members
    end
    
    def self.list
      url = "https://slack.com/api/channels.list"
      query_parameters = {
        token: ENV["SLACK_TOKEN"]
      }
      channel_objects = Recipient.get(url, query_parameters)
      
      channel_list = []
      channel_objects["channels"].each do |channel|
        channel_basic = self.new(channel["id"], channel["name"], channel["topic"], channel["members"])
        #member["display_name"], member["email"] add back in later
        channel_list << channel_basic
      end
      return channel_list
    end  
    
    def send_msg(message)
      Recipient.send_msg(message, @slack_id)
    end
    
    def details      
      channel_details = {}
      
      
      channel_details["slack_id"] = self.slack_id
      channel_details["name"] = self.name
      channel_details["topic"] = self.topic
      channel_details["members"] = self.members
      
      
      return channel_details
    end
    
    
  end
end
