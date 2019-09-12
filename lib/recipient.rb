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

    # def send_message(message)
    # end

    def details
      raise NotImplementedError.new("Details should be implemented in child class")
    end

    def self.list
      raise NotImplementedError.new("Self.list should be implemented in child class")
    end

  end
end
