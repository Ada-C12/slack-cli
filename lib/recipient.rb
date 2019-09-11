require 'httparty'
require 'dotenv'

Dotenv.load

class Recipient
  
  attr_reader :slack_id, :name
  
  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end
  
  def send_message(message)
    
  end
  
  def self.get(url, params: {token: KEY})
    
    response = HTTParty.get(url, query: params)
  end
  
  def details
    
  end
  
  def self.list
    return @name
  end
  
end