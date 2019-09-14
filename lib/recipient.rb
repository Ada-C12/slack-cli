require 'httparty'
require 'dotenv'
require_relative 'slack_api_error'

Dotenv.load

module Slack
  class Recipient
    
    attr_reader :name, :id
    
    def initialize(name: , id: )
      @name = name
      @id = id
    end
    
    def self.get(url, params)
      response = HTTParty.get(url, query: params)
      
      if response.code != 200 || response['ok'] == false
        raise Slack_Api_Error.new "Error! No response found."
      end
      
      return response
    end
    
    def self.list
      raise NotImplementedError, 'Implement me in a child class!'
    end
    
    def details
      raise NotImplementedError, 'Implement me in a child class!'
    end
    
    def send_message(message)
      send_url = "https://slack.com/api/chat.postMessage"
      send_query = {token: ENV["SLACK_TOKEN"], channel: self.id, text: message}
      outcome = HTTParty.post(send_url, query: send_query)
      return outcome
    end
    
  end
end