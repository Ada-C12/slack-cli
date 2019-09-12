require 'dotenv'
require_relative 'recipient'
require "pry"

module Slack
  class User < Recipient 
    attr_reader :real_name, :display_name
    
    def initialize(slack_id, name, real_name)
      super(slack_id, name)
      @real_name = real_name
      @display_name = display_name
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
    
    
    def details
      # users = self.class.list
      
      user_details = {}
      # identified_user = users.find do |member|
      #   member == selected_user
      # end
      
      user_details["slack_id"] = self.slack_id
      user_details["name"] = self.name
      user_details["real_name"] = self.real_name
      #user_details["display_name"] = self.display_name
      # user_details["email"] = identified_user["email"]
      
      return user_details
    end
    
    #depends on getting the select object?
    #?
    # id 
    # user name
    # real name
    
  end
  
end