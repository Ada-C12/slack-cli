require "httparty"
require "dotenv"

module Slack
  class Recipient
    attr_reader :name, :slack_id

    def initialize(name:, slack_id:)
      @name = name
      @slack_id = slack_id
    end

    def self.get(url, params)
      return HTTParty.get(url, params)
    end

    def send_message(message)
      body = {
        token: key,
        channel: slack_id,
        text: message,
      }

      response = HTTParty.post(MESSAGE_URL, body: body)

      if response["ok"] != true
        raise StandardError, "Invalid request. Error is #{response.code}: #{response.message}"
      end
    end

    private

    def self.list
      raise NotImplementedError, "Implement me in a child class!"
    end

    def details
      raise NotImplementedError, "Implement me in a child class!"
    end
  end
end
