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
      channels = []
      
      response["channels"].each do |channel|
        channel_hash = {}
        channel_hash[:channel_name] = channel["name"]
        channel_hash[:topic] = channel["topic"]["value"]
        channel_hash[:member_count] = channel["num_members"]
        channel_hash[:slack_id] = channel["id"]
        
        channels << channel_hash
      end
      return channels
    end
  end
end
