require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load 

module SlackCli
  class Recipient
    def self.send_message(channel:, text:)
      method_url = "https://slack.com/api/chat.postMessage"
      query_params = {
        token: ENV["SLACK_TOKEN"],
        channel: channel,
        text: text  
      }
      slack_post = HTTParty.post(method_url, query: query_params)
      puts slack_post
      puts channel
    end 
  end 

end 