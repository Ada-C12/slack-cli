require_relative 'recipient'

module Slack
  class User < Recipient
    attr_reader :status_text, :real_name, :status_emoji
    
    def initialize(slack_id:, name:, real_name:, status_text:, status_emoji:)
      super(slack_id: slack_id, name: name)
      
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end
    
    def details
      return "Slack id: #{slack_id}, Name: #{name}, Real name: #{real_name}, Status Text: #{status_text}, Status Emoji: #{status_emoji}"
    end
    
    def self.parse_response(response)
      users = response.parsed_response["members"].map do |member|
        member_slack_id = member["id"]
        member_name = member["name"]
        member_real_name = member["real_name"]
        member_status_text = member["profile"]["status_text"]
        member_status_emoji = member["profile"]["status_emoji"]
        
        User.new(slack_id: member_slack_id, name: member_name, real_name: member_real_name, status_text: member_status_text, status_emoji: member_status_emoji)
      end
      
      return users
    end
  end
end
