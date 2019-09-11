require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'recipient'
# require_relative 'channel'
require 'table_print'

Dotenv.load

module SlackCLI
  class User < Recipient
    def self.list_users
      response = HTTParty.get("https://slack.com/api/users.list?token=#{ENV['SLACK_TOKEN']}")
      array_of_users = []
      response["members"].each do |member|
        info_hash = {}
        info_hash["id"] = member["id"]
        info_hash["user_name"] = member["name"]
        info_hash["real_name"] = member ["profile"]["real_name"]
        array_of_users << info_hash
      end
      return array_of_users
    end
  end
end

tp SlackCLI::User.list_users
