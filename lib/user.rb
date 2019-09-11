require_relative 'recepient'
require 'dotenv'
Dotenv.load

module Slack
  class User
    attr_reader :slack_id, :name, :user_name
    
    USERS_LIST = "https://slack.com/api/users.list"
    
    def initialize(slack_id, name, user_name)
      @slack_id = slack_id
      @name = name
      @user_name = user_name
    end
    
    def self.list_users
      query = {
        token: ENV["SLACK_API_TOKEN"]
      }
      response = HTTParty.get(USERS_LIST, query: query)
      members = response["members"]
      
      users = []
      members.each do |user_hash|
        slack_id = user_hash["id"]
        name = user_hash["real_name"]
        user_name = user_hash["name"]
        users << User.new(user_name, name, slack_id)
      end
      return users
    end 
  end
end

