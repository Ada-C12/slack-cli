require 'httparty'
require 'dotenv'
Dotenv.load
require 'pry'
require_relative 'recipient'
require 'table_print'

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
  
  def self.printed_channels_list
    channels_array = []
    
    self.list["channels"].each do |channel|
      channels_array << {"name" => channel["name"],"topic" => channel["purpose"]["value"], "Member Count"=> channel["num_members"], "Slack ID"=> channel["id"]}
    end
    
    puts channels_array
  end

  def self.select_channel(desired_channel)

    self.printed_channels_list.each do |channel|
      if channel["name"] == desired_channel
        return desired_channel
      elsif channel["Slack ID"] == desired_channel
        return desired_channel
      else
        return nil
      end
    end
  end
end