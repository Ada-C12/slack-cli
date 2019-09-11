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
    
  end
end
