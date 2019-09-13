require_relative 'recipient'
require 'httparty'
require 'dotenv'

Dotenv.load


module SlackCLI
  class User < Recipient
    attr_reader :real_name
    
    def initialize(slack_id:, name:, real_name:)
      super(slack_id: slack_id, name: name)
      @real_name = real_name
    end
    
    def self.list
      response = self.get("https://slack.com/api/users.list")
      
      users = response["members"].map do |member|
        slack_id = member["id"]
        name = member["name"]
        real_name = member["real_name"]
        
        SlackCLI::User.new(slack_id: slack_id, name: name, real_name: real_name)
      end
      
      return users
    end
    
    def details
      key = ENV["API_TOKEN"]
      response = HTTParty.get("https://slack.com/api/users.info", query: {token: key , user: @slack_id})
      if response.keys.include? "error"  || response["ok"] == false
        raise SlackCLI::SlackApiError
      end

      status = response["user"]["profile"]["status_text"]
      is_bot = response["user"]["is_bot"] ? "true" : "false"

      "Slack ID: #{slack_id}\n" +
      "Name: #{name}\n" +
      "Real Name: #{real_name}\n" +
      "Status: #{status}" +
      "Is Bot?: #{is_bot}"
    end
  end
end
