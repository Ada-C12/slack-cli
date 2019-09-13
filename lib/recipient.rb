require 'httparty'
require 'dotenv'

Dotenv.load

module SlackCLI
  class Recipient
    attr_reader :slack_id, :name
    
    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end
    
    def send_message(msg)
      post_parameters = {
        token: ENV['SLACK_KEY'],
        channel: self.slack_id,
        text: msg
      }
      response =  HTTParty.post('https://slack.com/api/chat.postMessage', query: post_parameters)
      if response.code == 200
        puts "Message sent successfully."
      else
        puts "Message not sent, error code #{response.code}."
      end
      return response 
    end 
    
    def self.get(url, query)
      response = HTTParty.get(url, query)
      if response.code != 200
        puts "Something went wrong, error code #{response.code}."
      end
      return response 
    end
  end
end
