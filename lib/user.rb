require 'httparty'
require 'dotenv'
require_relative 'recipient'

Dotenv.load

module SlackCLI
  class User < Recipient
    
    attr_reader :real_name, :status_text, :status_emoji
    def initialize(slack_id, name, real_name, status_text, status_emoji = nil)
      super(slack_id, name)
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end
    
    #factory method for producing individual users from json
    def self.json_parse(json)
      users = []
      json["members"].each do |member|
        new_user = SlackCLI::User.new(member["id"], member["profile"]["display_name"], member["profile"]["real_name"], member["profile"]["status_text"], member["profile"]["status_emoji"])
        users << new_user
      end
      return users
    end
  end
end