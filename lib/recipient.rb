require_relative 'slack_api_error'

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
    
  end
  
end