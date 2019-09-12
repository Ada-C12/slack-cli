require 'httparty'
require 'dotenv'
Dotenv.load
require 'pry'

class Channel < Recipient
  attr_reader :slack_id, :name, :topic, :member_count
  @@channels_list = []
  BASE_URL = "https://slack.com/api/channels.list"
  API_KEY = ENV['SLACK_API_TOKEN']
  
  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
    @@channels_list << self
  end
  
  def self.list
    query = {
      token: API_KEY
    }
    response = HTTParty.get(BASE_URL, query: query)
    
    return response
  end

  def printed_channels_list
    channels_array = []

    self.list["channels"].each do |channel|
      channels_array << channel["name"]
    end

    return channels_array
  end
end