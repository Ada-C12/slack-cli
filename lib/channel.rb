require_relative 'recipient'

module SlackCLI
  class Channel < Recipient
    attr_reader :topic, :member_count

    def initialize(slack_id:, name:, topic:, member_count:)
      super(slack_id: slack_id, name: name)
      @topic = topic
      @member_count = member_count
    end

    def self.list
      response = self.get("https://slack.com/api/channels.list")

      channels = response["channels"].map do |channel|
        slack_id = channel["id"]
        name = channel["name"]
        topic = channel["topic"]["value"]
        member_count = channel["members"].length

        SlackCLI::Channel.new(
          slack_id: slack_id, 
          name: name, 
          topic: topic, 
          member_count: member_count
        )
      end
      
      return channels
    end

    def details
      key = ENV["API_TOKEN"]
      response = HTTParty.get("https://slack.com/api/channels.info", query: {token: key , channel: @slack_id})
      if response.keys.include? "error"  || response["ok"] == false
        raise SlackCLI::SlackApiError
      end

      purpose = response["channel"]["purpose"]["value"]
      is_private = response["channel"]["is_private"] ? "true" : "false"

      "Slack ID: #{slack_id}\n" +
      "Name:  #{name}\n" +
      "Topic: #{topic}\n" +
      "Member Count: #{member_count}\n" +
      "Purpose: #{purpose}\n" +
      "Is Private? #{is_private}"
    end
  end
end
