#lib/channel.rb
require 'httparty'
require 'awesome_print'
require 'dotenv'
require_relative "recipient"
Dotenv.load

module Slack
  CHANNEL_URI = 'https://slack.com/api'
  CHANNEL_KEY = ENV['API_KEY']
  class  Channel < Recipient
    attr_reader :topic, :member_count
    
    def initialize(name, id, topic, member_count)
      super(name, id)
      @topic = topic
      @member_count = member_count
    end
    
    def self.channels_list
      channels = []
      response = HTTParty.get("#{CHANNEL_URI}/channels.list", query: {token: CHANNEL_KEY}) 
      response.parsed_response["channels"].each do |channel|
        name =  channel["name"]
        id =  channel["id"]
        topic = channel["topic"]
        member_count = channel["num_members"]
        channel = Slack::Channel.new(name, id, topic, member_count)  
        channels  << channel
      end
      return channels
    end
  end
end