require 'httparty'
require 'dotenv'
require_relative 'recipient'

Dotenv.load

module SlackCLI
  class Channel < Recipient

    def intiialize(slack_id, name, topic, member_count)
      super(slack_id, name)
      @topic = topic
      @member_count = member_count
    end

    #factory method for producing individual channels from json
    def self.list(json)
      channels = []
      json["channels"].each do|channel|
        new_ch = Channel.new(channel["id"], channel["name"], channel["topic"], channel["topic"]["value"], channel["num_members"])
        channels << new_ch
      end
    return channels
    end