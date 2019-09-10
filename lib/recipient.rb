require 'httparty'
require 'awesome_print'
require 'dotenv'
require 'table_print'
# require_relative "../lib/channel.rb"
# require_relative "../lib/user.rb"
require_relative "../lib/slack.rb"

Dotenv.load

module SlackCLI
  class Recipient
    attr_reader :slack_id, :name
    
    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end
  end
end
