require_relative 'recepient'
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
    
    def self.list_channel
      query = {
        token: ENV["SLACK_API_TOKEN"]
      }
      response = HTTParty.get(CHANNELS_LIST, query: query)
      channels = response[:channels]
      
      channels = []
      channels.each do |channel_hash|
        name = user_hash["name"]
        topic = user_hash["topic"]
        member_count = user_hash["member_count"]
        slack_id = user_hash["slack_id"]
        channels << Channel.new(name, topic, member_count, slack_id)
      end
      return channels
    end 
  end
end





