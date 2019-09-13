class SlackApiError < StandardError ; end

module Slack
  class Recipient
    attr_reader :slack_id, :name
    
    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
    end
    
    def self.get(url, parameters)
      response = HTTParty.get(url, parameters)
      
      unless response.code == 200 && response["ok"]
        raise SlackApiError, "Invalid API request with code #{response.code} and message #{response["error"]}."
      end
      
      return self.parse_response(response)
    end
    
    def details
      raise NotImplementedError, "Can't implement from recipient class."
    end
    
    def self.parse_response(response)
      raise NotImplementedError, "Can't implement recipient class."
    end
  end
end
