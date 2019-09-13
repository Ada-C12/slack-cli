require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load 

module SlackCli
  class Recipient
    def self.send_message(recipient:, message:)
      method_url = "https://slack.com/api/chat.postMessage"
      query_params = {
        token: ENV["SLACK_TOKEN"],
        channel: recipient,
        text: message
      }
      slack_post = HTTParty.post(method_url, query: query_params)
      return slack_post
    end 
  end 

end 