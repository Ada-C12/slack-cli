module Slack
  class Recipient
    attr_reader :slack_id, :name
    
    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
    end
    
    def self.get(url, parameters)
      response = HTTParty.get(url, parameters)
      
      return self.parse_response(response)
    end
    
    def details
      raise NotImplementedError, "Can't implement"
    end
    
    def self.parse_response(response)
      raise NotImplementedError, "Can't implement"
    end
    
    # def self.list
    #   raise NotImplementedError, "Can't implement"
    # end
    
    # def send_message(message)
    # end
    
  end
end