
module Slack
  class SlackApiError < StandardError; end
  
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
    
    def self.send_msg(message, channel)
      # BASE_URL = "https://slack.com/api/chat.postMessage"
      response = HTTParty.post(
        "#{"https://slack.com/api/chat.postMessage"}",
        body:  {
          token: ENV["SLACK_TOKEN"],
          text: message,
          channel: channel
        },
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
      )
      
      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackApiError, "Error when posting #{message} to #{channel}, error: #{response.parsed_response["error"]}"
      end
      
      return true
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