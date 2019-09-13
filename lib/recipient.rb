require "pry"
class SlackAPIError < StandardError ; end 

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.get(url, query)
    response = HTTParty.get(url, query: query)
    return response
  end

  def details
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def self.list
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def send_message(message)
    url = "https://slack.com/api/chat.postMessage"
    body = {token: ENV['SLACK_TOKEN'], 
    text: message,
    channel: @slack_id}

    message_post = HTTParty.post(url, body: body)

    unless message_post.code == 200 && message_post["ok"]
      raise SlackAPIError.new("Error when posting #{message} to #{@slack_id}")
    end 
  
    return true 
  end
  
end