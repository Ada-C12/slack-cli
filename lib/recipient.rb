require "httparty"
require 'pry'

module Slack
  class Recipient
    URL = "https://slack.com/api/users.list"
    attr_reader :slack_id, :name
    
    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end
    
    # def details
    #  raise NotImplementedError, 'Implement me in a child class!'
    # end 
    
    # def self.list
    #   raise NotImplementedError, 'Implement me in a child class!'
    # end
    
    def send_message(message)
    end
    
    def self.get(url)     
      response = HTTParty.get(url, query: {token: ENV['SLACK_API_TOKEN']})
      
      return reponse
    end
  end  
end 
