require "httparty"
require "dotenv"

module Slack
  class Recipient
    attr_reader :name, :slack_id

    def initialize
      @name = name
      @slack_id = slack_id
    end

    def self.get(url, params)
      return HTTParty.get(url, params)
    end

    def send_message(message)
    end

    private

    def self.list
    end

    def details
    end
  end
end
