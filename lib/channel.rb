require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'recipient'
require 'table_print'

Dotenv.load
# we are returning an array of channels (2x what we are expecting)
module SlackCLI
  class Channel < Recipient
    def self.list_channels
      response = HTTParty.get("https://slack.com/api/channels.list?token=#{ENV['SLACK_TOKEN']}")
      array_of_channels = []
      
      response["channels"].each do |channel|
        info_hash = {}
        info_hash["id"] = channel["id"]
        info_hash["name"] =  channel["name"]
        info_hash["topic"] = channel["topic"]["value"]
        info_hash["member_count"] =  channel["members"].length
        array_of_channels << info_hash
      end
      return response["channels"]
    end
  end
end

ap SlackCLI::Channel.list_channels
