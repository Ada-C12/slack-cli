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
  end
end
