require_relative 'recipient'
# require 'httparty'
# require  'dotenv'

# Dotenv.load




class Channel < Recipient
  attr_reader :topic, :member_count
  
  def initialize(slack_id:, name:, topic:, member_count:)
    super(slack_id: slack_id, name: name)
    @topic = topic
    @member_count = member_count
  end
  
  
  def details
    
    
  end
  
  
  def self.list
    channels = self.get("https://slack.com/api/conversations.list")["channels"]

    channels.map do |channel|
      name = channel["name"]
      topic = channel["topic"]["value"]
      member_count = channel["num_members"]
      slack_id = channel["id"]

      
    end
    return channels
    # channels = response["channels"]
    
    # name = channels.map do |channel|
    #   channel['name']
    # end
    
    # topic = channels.map do |channel|
    #   channel['topic']['value']
    # end
    
    # member_count = channels.map do |channel|
    #   channel['num_members']
    # end
    
    # slack_id = channels.map do |channel|
    #   channel['id']
    # end
    
    # name.length.times do |i|
    #   puts "Name: #{name[i]},\n
    #   Topic: #{topic[i]},\n
    #   Member count: #{member_count[i]},\n
    #   Slack ID: #{slack_id[i]}"
    # end
  end
end


print a = Channel.list
