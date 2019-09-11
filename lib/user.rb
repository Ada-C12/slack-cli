require_relative 'recipient'
require 'httparty'
require 'dotenv'

Dotenv.load

class User < Recipient
  attr_reader :id, :username, :real_name
  

  def initialize(id, username, real_name)
    super(id, name)
    @real_name = real_name
  end

  def details
  end


  def self.list
    # BASE_URL = "https://slack.com/api/users.list"
    # TOKEN = ENV["SLACK_TOKEN"]
  
    # query = {
    # token: TOKEN
    # }
  
    # response = HTTParty.get(BASE_URL, query: query)
  
  end
end


