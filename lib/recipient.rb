require 'httparty'
require 'awesome_print'
require 'dotenv'
require 'table_print'
require_relative "../lib/channel.rb"
require_relative "../lib/user.rb"
require_relative "../lib/slack.rb"

Dotenv.load

module SlackCLI
  class Recipient
    attr_reader :slack_id, :name
    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end
  end
end

#CHANNELS_URL = https://slack.com/api/channels.list
#MESSAGE_URL = https://api.slack.com/methods/chat.postMessage
URL = 'https://slack.com/api/users.list'
TOKEN = ENV['SLACK_TOKEN']


def self.get
  rec_response = HTTParty.get(URL, query: { token: TOKEN })
  ap rec_response["members"]
end

ap self.get 

