require 'httparty'
require  'dotenv'

Dotenv.load


class Recipient
  attr_reader :slack_id, :name
  
  KEY = ENV['SLACK_TOKEN']
  
  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end
  
  
  
  def self.get(url)
    HTTParty.get(url, query: {token: KEY})
  end
  
  
  
  def self.list
    raise NotImplementedError 'Children implement this'
  end
  
end
