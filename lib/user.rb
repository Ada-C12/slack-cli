require_relative "../lib/recipient"
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
    end
    
    def self.list
      # USERS
      # URL_USERS = "https://slack.com/api/users.list"
      # response = HTTParty.get(URL_USERS, query: {token: ENV['SLACK_API_TOKEN']})
      #p response
      
      reponse = User.get("https://slack.com/api/users.list")
      users = []
      
      response["members"].each do |user|
        
        user_hash = {}
        user_hash[:user_name] = user["name"]
        user_hash[:real_name] = user["real_name"]
        user_hash[:slack_id] = user["id"]
        
        users << user_hash
      end
      
      return users
      #p users
    end 
  end 
end 

