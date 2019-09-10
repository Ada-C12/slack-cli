#!/usr/bin/env ruby
require 'httparty'
require 'awesome_print'
require 'dotenv'
require 'table_print'
Dotenv.load

require_relative "../lib/recipient.rb"
# require_relative "../lib/user.rb"
# require_relative "../lib/channel.rb"

module SlackCLI
  
  class Slack
    @@URL = 'https://slack.com/api/users.list'
    @@TOKEN = ENV['SLACK_TOKEN']
    
    attr_reader :users, :channels, :selected
    
    def initialize(users, channels, selected)
      @users = users
      @channels = channels
      @selected = selected
    end
    
    
    def users_list(url, token)
      users_response = HTTParty.get(@@URL, query: { token: @@TOKEN })
      ap users_response["members"]
    end
    
    
  end # of class
  
end # of module

def main
  ap users_list(@@URL, @@TOKEN)
  puts "Welcome to the Ada Slack CLI!"
  puts "Thank you For using the Ada Slack CLI"
end
# main if __FILE__ == $PROGRAM_channel
SlackCLI::Slack.main


# CHANNELS_URL = https://slack.com/api/channels.list
# MESSAGE_URL = https://api.slack.com/methods/chat.postMessage
