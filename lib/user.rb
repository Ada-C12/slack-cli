require 'httparty'
require 'dotenv'
require_relative 'recipient'

Dotenv.load

module SlackCLI
  class User < Recipient
    
    def initialize(slack_id, name, real_name, status_text, status_emoji = nil)
      super(slack_id, name)
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end
  end
end