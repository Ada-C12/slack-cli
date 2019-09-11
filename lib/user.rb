require 'dotenv'
require_relative 'recipient'

module Slack
  class User < Recipient 
    attr_reader :real_name
    
    def initialize(slack_id, name, real_name)
      super(slack_id, name)
      @real_name = real_name
    end
    
    def list
      url = "https://slack.com/api/users.list"
      query_parameters = {
        token: ENV["SLACK_TOKEN"]
      }
      user_objects = Recipient.get(url, query_parameters)
      
      user_list = []
      user_objects["members"].each do |name|
        user_list << name["real_name"]
      end
      return user_list
    end
    
    def select(user_name: nil, slack_id: nil)
      #returns the user object that goes with passed in user_name?
      
      # error when no user exists
      
    end
    
    def details
      #depends on getting the select object?
      #?
      # id 
      # user name
      # real name
      # location?
      # email
    end
    
    def quit
    end
    
  end
end