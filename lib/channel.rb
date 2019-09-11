# require_relative 'recipient'
require 'httparty'
require  'dotenv'
# require 'awesome_print'
# require 'table_print'

Dotenv.load


class Channel
  attr_reader :topic, :member_count
  
  URL = "https://slack.com/api/channels.list"
  KEY = ENV['SLACK_TOKEN']
  
  
  def initialize(slack_id:, name:, topic:, member_count:)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end
  
  def details
    
    
  end
  
  
  def self.list
    response = HTTParty.get(URL, query: {token: KEY})
    
    @name = []
    @topic = []
    @member_count = []
    @slack_id = []

    channels = response["channels"]
    
    name = channels.map do |channel|
      channel['name']
    end
    
    topic = channels.map do |channel|
      channel['topic']['value']
    end
    
    member_count = channels.map do |channel|
      channel['num_members']
    end
    
    slack_id = channels.map do |channel|
      channel['id']
    end
    
    name.length.times do |i|
      puts "Name: #{name[i]},\n
      Topic: #{topic[i]},\n
      Member count: #{member_count[i]},\n
      Slack ID: #{slack_id[i]}"
    end
  end
end


# print a = Channel.list
