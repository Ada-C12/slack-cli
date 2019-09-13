require 'httparty'

module SlackBot
  class Recipient 
    attr_reader :slack_id, :name
    
    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
      
      if @slack_id.class != String || @slack_id.length != 9
        raise ArgumentError.new("Failure: slack_id must be a 9 character string")
      end 
    end
    
    def self.get(url)
      return response = HTTParty.get(url, query: {token: ENV["SLACK_TOKEN"]})
    end
    
    def send_message(slack_id:, message:)
      return response = HTTParty.post("https://slack.com/api/chat.postMessage", query: {token: ENV["SLACK_TOKEN"], channel: slack_id, text: message})
    end
    
    private 
    
    def details
      raise NotImplementedError, 'Implement me in a child class!'
    end
    
    def self.list
      raise NotImplementedError, 'Implement me in a child class!'
    end
    
  end
end
