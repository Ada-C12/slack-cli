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

    def self.get(url, query)
      response = HTTParty.get(url, query)
    end
  end
end

# details and self.list are abstract class methods
#   raise NotImplementedError, 'Implement me in a child class!'