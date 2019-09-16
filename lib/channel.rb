require_relative 'recipient'
require 'dotenv'
Dotenv.load

module Slack
  class Channel
    attr_reader :channel_name, :topic, :member_count, :slack_id
    CHANNELS_LIST = "https://slack.com/api/channels.list"
    CHAT_URL = "https://slack.com/api/chat.postMessage"
    
    def initialize(channel_name, topic, member_count, slack_id)
      @channel_name = channel_name
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
        channel_name = channel_hash["name"]
        topic = channel_hash["topic"]
        member_count = channel_hash["num_members"]
        slack_id = channel_hash["id"]
        channels_list << Channel.new(channel_name, topic, member_count, slack_id)
      end
      return channels_list 
    end 
    
    def details 
      "The channel name is #{channel_name} and the slack id is #{slack_id}"
    end
    
    # method for select channel, returns an instance of channel
    # input is a string 
    def self.select_channel(recipient_selection)
      channels = list_channels
      recipient = channels.find {| channel | channel.channel_name == recipient_selection || channel.slack_id == recipient_selection }
      return recipient
    end
    
    # method for send_message - just like in User.rb
    def send_message(message)
      response = HTTParty.post(
        CHAT_URL,
        body:  {
          token: ENV["SLACK_API_TOKEN"],
          text: message,
          channel: @slack_id # need slack_id, per Slack documentation for send_message 
        },
      )
      
      return response.code == 200 && response.parsed_response["ok"]
    end
  end
end





