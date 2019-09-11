require "httparty"
require "dotenv"
require "awesome_print"

Dotenv.load

require_relative "recipient"

module Slack
  class User < Recipient
    def initialize(name:, slack_id:)
      super(name, slack_id)
      @real_name = real_name
    end

    def self.list
      url = "https://slack.com/api/users.list"
      query_parameters = {
        token: ENV["SLACK_TOKEN"],
      }
      response = User.get(url, query: query_parameters)
      users_array = []
      response["members"].each do |member|
        user_hash = { "real name" => member["real_name"], "user name" => member["name"], "slack id" => member["id"] }
        users_array << user_hash
      end
      return users_array
    end

    def details
    end
  end
end
