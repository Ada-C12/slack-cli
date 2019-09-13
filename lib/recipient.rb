require 'httparty'
require 'dotenv'

Dotenv.load

module SlackCLI
  class SlackApiError < StandardError; end
  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
    end

    def self.get(url)
      key = ENV["API_TOKEN"]
      response = HTTParty.get(url, query: {token: key })
      if response.keys.include? "error"  || response["ok"] == false
        raise SlackCLI::SlackApiError
      end

      return response
    end

    def send_message(message)
      # pull out key to be @key?
      key = ENV["API_TOKEN"]
      response = HTTParty.post(
        "https://slack.com/api/chat.postMessage", 
        headers: {'Content-Type' => 'application/x-www-form-urlencoded'},
        body: {
          "token": key,
          "channel": @slack_id,
          "text": message
          }
        )

      if response.keys.include? "error"  || response["ok"] == false
        raise SlackCLI::SlackApiError.new("Message not sent due to error: #{response["error"]}")
      else
        return true
      end
    end

    def details
      raise NotImplementedError.new("Details should be implemented in child class")
    end

    def self.list
      raise NotImplementedError.new("Self.list should be implemented in child class")
    end

  end
end
