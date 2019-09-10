require "httparty"
require "dotenv"
require "awesome_print"

Dotenv.load

require_relative "recipient"

module Slack
  class Channel < Recipient
    attr_reader :topic, :member_count

    def initialize
      super(name, slack_id)
      @topic = topic
      @member_count = member_count
    end

    def self.list
      url = "https://slack.com/api/channels.list"
      query_parameters = {
        token: ENV["SLACK_TOKEN"],
      }
      response = Channel.get(url, query_parameters)
      channels = []

      response["channels"].each do |channel|
        name = channel["name"]
        slack_id = channel["id"]
        topic = channel["topic"]["value"]
        member_count = channel["members"].length
      end
    end

    def details
    end
  end
end
