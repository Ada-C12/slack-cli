require_relative "recipient"
require "httparty"
require 'pry'

module Slack
  class User < Recipient
    attr_reader :real_name
    
    def initialize(slack_id, name, real_name)
      super(slack_id, name)
      @real_name = real_name
    end
    
    def details
      tp self, "slack_id", "name", "real_name"
    end 
    
    def self.list   
      response = User.get("https://slack.com/api/users.list")
      users = []
      
      response["members"].each do |user|
        users << User.new(
          slack_id = user["id"],
          name = user["name"],
          real_name = user["real_name"],
        )
      end
      return users
    end 
  end
end
