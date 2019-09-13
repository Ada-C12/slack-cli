require 'httparty'
require_relative 'recipient'
require 'table_print'

class Channel < Recipient
  attr_reader :topic, :member_count
  
  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end
  
  def self.get
    response = super.find { |response| response["channels"] } 
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
    return "Channel name: #{name}
    Slack_ID: #{slack_id}
    Topic: #{topic}
    Member Count: #{member_count}"
  end
  
  def self.list
    tp self.get, :name, :slack_id, :topic, :member_count
  end
  
end