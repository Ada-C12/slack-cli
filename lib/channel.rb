require_relative 'recipient'
require 'httparty'
require 'dotenv'

Dotenv.load

module Slack
  class Channel < Recipient
    BASE_URL = "https://slack.com/api/channels.list"
    TOKEN = ENV["SLACK_TOKEN"]
    QUERY = {
      token: TOKEN
    }
    attr_reader :id, :name, :topic, :member_count

    def initialize(id, name, topic, member_count)
      super(id, name)
      @topic = topic
      @member_count = member_count
    end
  end

  def self.list
    response = self.get(BASE_URL + "channels.list", query: QUERY)

    channels = response["channels"].map do |channel|
      self.new(channel["id"], channel["name"], channel["topic"]["value"], channel["num_members"])
    end
    return channels
  end

  def details
    super.push("topic", "member_count")
  end
end