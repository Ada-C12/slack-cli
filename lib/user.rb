require 'dotenv'
require_relative 'recipient'
require_relative 'workspace'

module Slack
  class User < Recipient 
    attr_reader :real_name
    
    def initialize(slack_id, name, real_name)
      super(slack_id, name)
      @real_name = real_name
      @users = []
    end
    
    def list
      url = "https://slack.com/api/users.list"
      query_parameters = {
        token: ENV["SLACK_TOKEN"]
      }
      user_objects = Recipient.get(url, query_parameters)
      
      user_list = []
      @users = []
      user_objects["members"].each do |member|
        user_basic = {}
        @users << member 
        user_basic["slack_id"] = member["slack_id"]
        user_basic["name"] = member["name"]
        user_basic["real_name"] = member["real_name"]
      end
      return user_list
    end
    
    
    def details
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
  
  def quit
  end
  
end