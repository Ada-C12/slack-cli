module Slack
  class Channel
    attr_reader :channel_name, :topic, :member_count, :slack_id
    
    def initialize(channel_name:, topic:, member_count:, slack_id:)
      @channel_name = channel_name
      @topic = topic
      @member_count = member_count
      @slack_id = slack_id
    end
  end
end