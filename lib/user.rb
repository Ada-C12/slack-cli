require_relative "recipient"

module Slack
  class User < Recipient
    def initialize
      super(name, slack_id)
      @real_name = real_name
    end

    def self.list
    end

    def details
    end
  end
end
