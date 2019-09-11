require 'httparty'
require 'dotenv'
require_relative 'recipient'

Dotenv.load

module SlackCLI
  class Channel < Recipient
    attr_reader :slack_id, :name, :topic, :member_count

    def initialize(slack_id, name, topic, member_count)
      super(slack_id, name)
      @topic = topic
      @member_count = member_count
    end

    #factory method for producing individual channels from json
    def self.json_parse(json)
      channels = []
      json["channels"].each do|channel|
        new_ch = SlackCLI::Channel.new(channel["id"], channel["name"], channel["topic"]["value"], channel["num_members"])
        channels << new_ch
      end
      return channels
    end
  end
end

