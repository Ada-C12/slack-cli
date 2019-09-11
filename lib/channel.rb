require 'httparty'
require_relative 'recipient'

class Channel < Recipient
  attr_reader :topic, :member_count
  
  URL = "https://slack.com/api/conversations.list"
  KEY = ENV['SLACK_API_TOKEN']
  
  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end
  
  def self.get
    query_param = {
      token: KEY
    }
    response = HTTParty.get(URL, query: query_param)
    
    channels = []
    response["channels"].each do |channel|
      
      name =  channel["name"]
      slack_id = channel["id"]
      topic = channel["topic"]["value"]
      member_count = channel["num_members"]
      
      channels << self.new(slack_id, name, topic, member_count)
      
    end
    
    return channels 
    
  end
  
  def details
    
  end
  
  def self.list
    tp self.get, :name, :slack_id, :topic, :member_count
  end
  
end