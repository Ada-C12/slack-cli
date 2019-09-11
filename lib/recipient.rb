require "httparty"
require 'pry'

module Slack
  class Recipient
    URL = "https://slack.com/api/users.list"
    attr_reader :slack_id, :name
    
    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end
    
    # def send_message(message)
    # end
    
    # def self.get(url, query)
    #   query_parameters  = {
    #     token: ENV['SLACK_API_TOKEN']
    #   }    
    #   return response = HTTParty.get(URL, query: query_parameters)
    
    # end 
  end 
end
