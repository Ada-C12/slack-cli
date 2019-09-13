require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load 

module SlackCli
  class Recipient
    def send_message(recipient:, message:)
      method_url = "https://slack.com/api/chat.postMessage"
      query_params = {
        token: ENV["SLACK_TOKEN"],
        channel: recipient,
        text: message 
      }
      response = HTTParty.post(method_url, query: query_params)
    end 
  end 

end 