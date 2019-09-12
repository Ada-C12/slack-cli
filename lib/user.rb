require 'dotenv'
require_relative 'recipient'

module Slack
  class User < Recipient 
    attr_reader :real_name
    
    def initialize(slack_id, name, real_name)
      super(slack_id, name)
      @real_name = real_name
      
    end
    
    def self.list 
      url = "https://slack.com/api/users.list"
      query_parameters = {
        token: ENV["SLACK_TOKEN"]
      }
      user_objects = Recipient.get(url, query_parameters)
      
      user_list = []
      user_objects["members"].each do |member|
        # @users << member 
        user_basic = self.new(member["slack_id"], member["name"], member["real_name"])
        user_list << user_basic
      end
      return user_list
    end
    
    
    def details(user)
      user_details = {}
      identified_user = @users.find do |user|
        user == selected_user
      end
      
      user_details["slack_id"] = identified_user["slack_id"]
      user_details["name"] = identified_user["name"]
      user_details["real_name"] =i dentified_user["real_name"]
    end
    
    #depends on getting the select object?
    #?
    # id 
    # user name
    # real name
    
  end
  
end