#lib/message.rb
require "httparty"

class SlackApiError < StandardError ; end

module Slack  
  def self.send_msg(message, channel)
    
    response = HTTParty.post(
      "https://slack.com/api/chat.postMessage",
      body:  {
        token: ENV['API_KEY'],
        text: message,
        channel: channel
      },
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    )
    
    unless response.code == 200 && response.parsed_response["ok"]
      raise SlackApiError, "Error when posting #{message} to #{channel}, error: #{response.parsed_response["error"]}"
    end

    return true
  end
end
