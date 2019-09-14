require 'dotenv'
require_relative 'recipient'

module Slack
  class User < Recipient 
    attr_reader :real_name, :display_name, :time_zone
    
    def initialize(slack_id, name, real_name, display_name, time_zone)
      super(slack_id, name)
      @real_name = real_name
      @display_name = display_name
      @time_zone = time_zone
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
        user_basic = self.new(member["id"], member["name"], member["real_name"], member["profile"]["display_name"], member["tz"])
        user_list << user_basic
      end
      return user_list
    end
    
    def send_msg(message)
      Recipient.send_msg(message, @slack_id)
    end
    
    
    def details
      user_details = {}
      user_details["slack_id"] = self.slack_id
      user_details["name"] = self.name
      user_details["real_name"] = self.real_name
      user_details["display_name"] = self.display_name
      user_details["time_zone"] = self.time_zone
      
      return user_details
    end
    
  end
  
end