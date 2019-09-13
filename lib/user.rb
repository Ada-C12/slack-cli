require 'httparty'
require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji
  
  def initialize(slack_id, name, real_name, status_text, status_emoji)
    
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
    
    
  end
  
  def self.get
    response = super.find { |response| response["members"] }
    users = []
    response["members"].each do |member|
      
      name =  member["name"]
      slack_id = member["id"]
      real_name = member["real_name"]
      status_text = member["status_text"]
      status_emoji = member["status_emoji"]
      
      users << self.new(slack_id, name, real_name, status_text, status_emoji)
      
    end
    return users 
    
  end
  
  def details
    return "User name: #{name}
    Slack_ID: #{slack_id}
    Real Name: #{real_name}
    Status Text: #{status_text}
    Status Emoji: #{status_emoji}"
  end
  
  def self.list
    tp self.get, :name, :real_name, :slack_id
  end
  
end