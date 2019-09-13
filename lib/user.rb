require_relative 'recipient'

module SlackBot
  class User < Recipient
    attr_reader :real_name, :status_text, :status_emoji
    
    def initialize(slack_id:, name:, real_name:, status_text: nil, status_emoji: nil)
      super(slack_id: slack_id, name: name)
      
      @real_name = real_name
      @status_text = status_text || nil
      @status_emoji = status_emoji || nil
    end
    
    def details
      tp self, "slack_id", "name", "real_name"
    end
    
    def self.list
      response = User.get("https://slack.com/api/users.list")
      users = []
      
      response["members"].each do |member|
        users << User.new(
          slack_id: member["id"],
          name: member["name"],
          real_name: member["real_name"]
        )
      end
      
      return users
    end
  end
end
