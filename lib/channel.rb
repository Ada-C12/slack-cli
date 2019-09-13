require 'dotenv'
require_relative 'recipient'

Dotenv.load

module SlackCLI
  class Channel < Recipient
    attr_reader :slack_id, :name, :topic, :member_count
    
    def initialize(slack_id:, name:, topic:, member_count:)
      @slack_id = slack_id
      @name = name
      @topic = topic
      @member_count = member_count
    end
    
    def self.list
      response = HTTParty.get("https://slack.com/api/channels.list?token=#{ENV['SLACK_TOKEN']}")
      unless response["ok"]
        raise StandardError.new("Data Load Error")
      end
      array_of_channels = []
      
      response["channels"].each do |channel|
        info_hash = {
          slack_id: channel["id"],
          name: channel["name"],
          topic: channel["topic"]["value"],
          member_count: channel["members"].length
        }
        array_of_channels << SlackCLI::Channel.new(info_hash)
      end
      return array_of_channels
    end
  end
end
