#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
Dotenv.load('../.env')
require 'awesome_print'

#CHAT_URL = "https://slack.com/api/chat.postMessage"

# Wave 3
# method for send message
module Slack
  class Recipient
    attr_reader :slack_id, :name
    
    def self.send_message(message_recipient)
      users = list_users
      message_recipient = users.find { |user| user.user_name == message_recipient || user.slack_id == message_recipient }
      return message_recipient
    end
  end
end


