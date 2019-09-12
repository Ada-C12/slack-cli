require_relative 'recipient'

module SlackBot
  class Channel < Recipient
    attr_reader :topic, :member_count
    
    def initialize(slack_id:, name:, topic: nil, member_count:)
      super(slack_id: slack_id, name: name)
      
      # ask about this sytax for topic. Why not just @topic = topic?
      @topic = topic || nil
      @member_count = member_count
      
    end
    
    def self.list
      response = Channel.get("https://slack.com/api/conversations.list")
      channel_list = []
      
      response["channels"].each do |channel|
        channel_list << Channel.new(
          slack_id: channel["id"],
          name: channel["name"],
          topic: channel["topic"]["value"],
          member_count: channel["num_members"]
        )
        
      end
      # require "pry"
      # binding.pry
      return channel_list
    end
  end
end
