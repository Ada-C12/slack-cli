require_relative 'recipient'
require 'httparty'
require 'dotenv'

Dotenv.load

class Channel < Recipient
  attr_reader :id, :name, :topic, :member_count

  def initialize(id, name, topic, member_count)
    super(id, name)
    @topic = topic
    @member_count = member_count
  end

  def details
  end


  def self.list
  #   BASE_URL = "https://slack.com/api/channels.list"
  #   TOKEN = ENV["SLACK_TOKEN"]
  
  #   query = {
  #   token: TOKEN
  #   }
  
  # response = HTTParty.get(BASE_URL, query: query)
  
  # response["slackbot"]["members".first]["id"]
  end
end