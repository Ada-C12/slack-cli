require 'httparty'
require  'dotenv'

Dotenv.load


class Recipient
  attr_reader :slack_id, :name
  
  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
    
   
  end
  
  
  def send_message(message)
    
    
  end
  
  
  def self.get(url)
    HTTParty.get(url, query: {token: TOKEN})
  end
  
  
  def details
    
    
  end
  
  
  def self.list
    raise NotImplementedError 'Children implement this'
    
    
  end

  
  private
  TOKEN = ENV['SLACK_TOKEN']


end
