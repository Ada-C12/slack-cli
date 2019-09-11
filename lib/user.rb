require 'httparty'
require_relative 'channel'
require_relative 'user'
require_relative 'workspace'

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji
  URL = "https://slack.com/api/users.list"
  KEY = ENV['SLACK_API_TOKEN']
  
  def initialize(slack_id, name, real_name, status_text, status_emoji)
    
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
    
    
  end
  
  def self.get
    query_param = {
      token: KEY
    }
    response = HTTParty.get(URL, query: query_param )
    
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
    
  end
  
  def self.list
    users = self.get
    user_info = ""
    users.each_with_index do |user, index|
      user_info += "User #{index + 1}'s name is #{user.name}, real name is #{user.real_name}, and slack id is #{user.slack_id}.\n"
    end
    return user_info
  end
  
end