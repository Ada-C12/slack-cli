require_relative 'recipient'

module Slack
  class Channel < Recipient
    attr_reader :topic, :member_count
    
    def initialize(slack_id:, name:, topic:, member_count:)
      super(slack_id: slack_id, name: name)
      
      @topic = topic
      @member_count = member_count 
    end
    
    def details
      return "Slack id: #{slack_id}, Name: #{name}, Topic: #{topic}, Member_count: #{member_count}"
    end
    
    def self.parse_response(response)
      channels = response.parsed_response["channels"].map do |channel|
        channel_slack_id = channel["id"]
        channel_name = channel["name"]
        channel_topic = channel["topic"]["value"]
        channel_member_count = channel["members"].length
        
        Channel.new(slack_id: channel_slack_id, name:channel_name, topic: channel_topic, member_count: channel_member_count)
      end
      
      return channels
    end
  end
end
