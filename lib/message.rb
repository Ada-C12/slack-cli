#lib/message.rb
require "httparty"

# class SlackApiError < StandardError ; end

module Slack
  BASE_URL = 'https://slack.com/api/'
  API_KEY = ENV['API_KEY']
  
  def self.send_msg(message, channel)
    
    response = HTTParty.post(
      "#{BASE_URL}/chat.postMessage",
      body:  {
        token: API_KEY,
        text: message,
        channel: channel
      },
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    )
    
    unless response.code == 200 && response.parsed_response["ok"]
      puts "Error when posting #{message} to #{channel}, error: #{response.parsed_response["error"]}"
    end

    return true
  end
end