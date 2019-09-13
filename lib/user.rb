require_relative 'recepient'
require 'dotenv'
Dotenv.load

module Slack
  class User
    attr_reader :slack_id, :name, :user_name
    
    USERS_LIST = "https://slack.com/api/users.list"
    CHAT_URL = "https://slack.com/api/chat.postMessage"
    
    
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
    
    def details 
      "The name is #{@name}, the user name is #{@user_name}, and the slack id is #{@slack_id}"
    end
    
    # method for send message
    
    # module SlackApi
    #  CHAT_URL = "https://slack.com/api/chat.postMessage"
    
    #   API_KEY = ENV['SLACK_TOKEN']
    
    #   def self.send_msg(message, channel)
    
    #     response = HTTParty.post(
    #       CHAT_URL,
    ,
    #       body:  {
    #         token: API_KEY,
    #         text: message,
    #         channel: channel
    #       },
    #       headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    #     )
    
    #     return response.code == 200 && response.parsed_response["ok"]
    #   end
    # end
  end
end

