require 'httparty'

class Recipient
  
  attr_reader :slack_id, :name
  
  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end
  
  def send_message(message)
    
  end
  
  def self.get(url, params)
    response = HTTParty.get(url, query: params)
  end
  
  private
  def details
    
  end
  
  def self.list
    
  end
  
end