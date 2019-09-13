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
      "Slack ID: #{slack_id}\n
      Name:  #{name}\n
      Topic: #{topic}\n 
      Member Count: #{member_count}"
    end
  end
end
