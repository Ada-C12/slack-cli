require_relative 'recipient'

require 'httparty'
require 'dotenv'
require 'awesome_print'
require 'table_print'
require 'pry'
require 'awesome_print'
Dotenv.load

class User < Recipient
  attr_accessor :slack_id
  
  URL = "https://slack.com/api/users.list"
  KEY = ENV['SLACK_TOKEN']
  
  def initialize(slack_id:, user_name:, real_name:) 
    # super(slack_id, name)
    @user_name = user_name
    @real_name = real_name
    @slack_id = slack_id
  end
  
  def details
    
    #real_name
    #status_text
    #status_emoji
    
  end
  
  
  def self.list
    response = HTTParty.get(URL, query: {token: KEY})
    members = response["members"]
    
    users = []
    
    members.each do |member|
      user = self.new(slack_id: member["id"], real_name: member["real_name"], user_name: member["name"])
      binding.pry
      users << user
      
      #tp and self.get
    end
    return users
    # users.each do |user| 
    #   puts use
    # end
  end
  
end

p User.list
