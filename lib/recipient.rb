require 'httparty'
require 'dotenv'

Dotenv.load

module SlackCLI
  class Recipient

    attr_reader

    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end

    def send_message
    end

    def self.get(URL, query)
      response = HTTParty.get(URL, query)
    end
