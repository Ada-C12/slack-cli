require 'httparty'
require 'dotenv'
require_relative "recipient"
require 'awesome_print'


Dotenv.load

USER_URL = "https://slack.com/api/users.list"

module Slack
  
  class User < Recipient
    attr_reader :id, :name, :real_name, :status_text, :status_emoji
    
    def initialize(id:, name:, real_name:, status_text:, status_emoji:)
      super(id: id, name: name)
      
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
      
    end
    
    def self.list
      
      query = {
        token: ENV["SLACK_TOKEN"]
      }
      response = HTTParty.get(USER_URL, query: query)
      
      list = response["members"].map do |member|
        self.new(id: member['id'], name: member['name'], real_name: member['real_name'], status_text: member['profile']['status_text'], status_emoji: member['profile']['status_emoji'])
      end
      
      return list
      
    end
    
    
  end
end