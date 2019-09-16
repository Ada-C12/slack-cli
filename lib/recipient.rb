#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
Dotenv.load('../.env')
require 'awesome_print'

CHAT_URL = "https://slack.com/api/chat.postMessage"

module Slack
  class Recipient
    attr_reader :slack_id, :name
    
  end
end


