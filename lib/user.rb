require_relative 'recipient'
require 'httparty'
require 'dotenv'

Dotenv.load

class User < Recipient
  # BASE_URL = "https://slack.com/api/users.list"
    # TOKEN = ENV["SLACK_TOKEN"]
  
    # query = {
    # token: TOKEN
    # }
  
  attr_reader :id, :username, :real_name
  
  def initialize(id, name, real_name)
    super(id, name)
    @real_name = real_name
  end

  def self.list
    
    # response = self.get(BASE_URL, query: query)

    # iterate through response["members"]
    reponse["members"].map do |member|
      self.new(user["id"], member["name"], member["real_name"])
  
  end

  def details
    # prints out details
  end
end


