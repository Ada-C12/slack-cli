require 'httparty'
require 'dotenv'

Dotenv.load

module SlackCLI
  class Recipient
    attr_reader :slack_id, :name

    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
    end

    def self.get(url)
      key = ENV["API_TOKEN"]
      response = HTTParty.get(url, query: {token: key })

      return response
    end

  end
end
