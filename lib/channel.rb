require_relative 'recipient'
require 'httparty'
require  'dotenv'

Dotenv.load


class Channel < Recipient
  attr_reader :topic, :member_count
  
  URL = "https://slack.com/api/channels.list"
  KEY = ENV['SLACK_TOKEN']
  
  # response = HTTParty.get(url, query: {token: key})
  
  def initialize
    # (slack_id:, name:, topic:, member_count:)
    # super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end
  
  def details
    
    
  end
  
  
  def self.list
    # binding.pry
    response = HTTParty.get(URL, query: {token: KEY})
  p response["channels"].first
    
 
  end
end


p  a = Channel.list
