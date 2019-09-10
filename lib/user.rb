require 'httparty'
require 'dotenv'
require_relative 'recipient'

Dotenv.load

module SlackCLI
  class User < Recipient

    def intiialize(slack_id, name, real_name, status_text, status_emoji)
      super(slack_id, name)
      @status_text = status_text
      @status_emoji = status_emoji
    end