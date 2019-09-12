module SlackCLI
  class Channel < Recipient
    attr_reader :topic, :member_count
    
    def initialize(slack_id:, name:, topic:, member_count:)
      super(slack_id, name)
      @topic = topic
      @member_count = member_count
    end
    
    def get_message_history
      url = "https://slack.com/api/conversations.history"
      query = { token: ENV["SLACK_API_TOKEN"] , channel: slack_id, limit: 25}
      response = HTTParty.get(url, query: query)
      
      return response
    end
    
    def self.all
      channels = []
      
      response = Channel.get("channels.list")
      
      response["channels"].each do |channel|
        slack_id = channel["id"]
        name = channel["name"]
        topic = channel["topic"]["value"]
        member_count = channel["num_members"]
        
        channels << SlackCLI::Channel.new(slack_id: slack_id, name: name, topic: topic, member_count: member_count)
      end
      return channels
    end
  end
end
