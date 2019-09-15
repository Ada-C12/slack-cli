require "httparty"
require 'pry'

class API_Error < StandardError
end
module Slack
  class Recipient
    URL = "https://slack.com/api/users.list"
    attr_reader :slack_id, :name
    
    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end
    
    def details
      raise API_Error.new, 'Implement me in a child class!'
    end
    
    def self.list
      raise API_Error.new, 'Implement me in a child class!'
    end
    
    def self.get(url)     
      response = HTTParty.get(url, query: {token: ENV['SLACK_API_TOKEN']})
      return response
    end
    
    def send_message(slack_id, message)
      response = HTTParty.post("https://slack.com/api/chat.postMessage", query: {token: ENV['SLACK_API_TOKEN'], channel: slack_id, text: message})
      
      unless response.code ==  200
        raise ExceptionError, "Message not sent."
      end 
      return response
    end
  end  
end
