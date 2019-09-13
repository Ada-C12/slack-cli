require 'HTTParty'
require 'dotenv'

class SlackApiError < StandardError 
end

module SlackCLI
  class Recipient
    def initialize
    end
    
    def self.list
      raise SlackApiError.new("Call this method in child class")
    end
  end
end

