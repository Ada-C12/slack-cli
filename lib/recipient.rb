require 'httparty'
require 'dotenv'

Dotenv.load

class SlackAPIError < StandardError; end

class Recipient
  
  attr_reader :slack_id, :name
  
  BASE_URL = "https://slack.com/api/"
  KEY = ENV['SLACK_API_TOKEN']
  
  
  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end
  
  def send_message(message, channel)
    response = HTTParty.post(
      BASE_URL + "chat.postMessage", 
      
      body:  {
        token: KEY, 
        text: message, 
        channel: channel,
        as_user: true
      },
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    )
    if response["ok"] == true
      return true
    end
    return false if SlackAPIError
  end
  
  
  def self.get
    query_param = {
      token: KEY
    }
    users = HTTParty.get(BASE_URL + "users.list", query: query_param)
    channels = HTTParty.get(BASE_URL + "conversations.list", query: query_param)
    response = [users, channels]
    
    if response[0]["ok"] == true
      return response
    else
      raise SlackAPIError
    end
  end
  
  def details
    raise NotImplementedError
  end
  
  def self.list
    raise NotImplementedError
  end
  
end