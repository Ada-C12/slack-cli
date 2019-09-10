require 'httparty'

module Slack
  class Recipient 
    attr_reader :slack_id, :name
    
    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end
    
    # pass down methods that will send messages 
    # pass down: make a request to API (get)
    # raise error if API is down or nil -- maybe do in another class?
    # list all the users or channels
    
    def send_message(message)
      
    end
    
    def details
      raise NotImplementedError, "Implement me in a child class"
    end
    
    def self.get(url, params)
      response = HTTParty.get(url, query: params)
    end
    
    def self.list
      raise NotImplementedError, "Implement me in a child class"
    end
    
  end
end