# require_relative 'recipient'
require 'httparty'
require  'dotenv'
require 'awesome_print'

Dotenv.load


class Channel
  attr_reader :topic, :member_count
  
  URL = "https://slack.com/api/channels.list"
  KEY = ENV['SLACK_TOKEN']
  
  
  def initialize
    # (slack_id:, name:, topic:, member_count:)
    # super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end
  
  def details
    
    
  end
  
  
  def self.list
    response = HTTParty.get(URL, query: {token: KEY})
    
    channel_name = []
    channel_topic = []
    channel_member_ct = []
    channel_slack_id = []
    channels = response["channels"]
    
    channel_name = channels.map do |channel|
      channel['name']
    end
    
    channel_topic = channels.map do |channel|
      channel['topic']['value']
    end
    
    channel_member_ct = channels.map do |channel|
      channel['num_members']
    end
    
    channel_slack_id = channels.map do |channel|
      channel['id']
    end
    
    channel_name.length.times do |i|
      puts "Name: #{channel_name[i]},\n
      Topic: #{channel_topic[i]},\n
      Member count: #{channel_member_ct[i]},\n
      Slack ID: #{channel_slack_id[i]}"
    end
  end
end


print a = Channel.list
