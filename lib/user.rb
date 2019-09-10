require 'dotenv'
require_relative 'recipient'

module Slack
  class User < Recipient 
    attr_reader :real_name
    
    def initialize(real_name)
      super(slack_id, name)
      @real_name = real_name
    end
    
    def details
    end
    
    def list
      url = "https://slack.com/api/users.list"
      
      KEY = ENV["SLACK_TOKEN"]
      query_parameters = {
        token: KEY
      }
      
      list = self.get(url, query: query_parameters) 
      
    end
    
    
  end
end