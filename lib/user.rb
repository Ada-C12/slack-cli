require_relative 'recipient'
require 'httparty'
require 'dotenv'

Dotenv.load

class User < Recipient
  BASE_URL = "https://slack.com/api/users.list"
  TOKEN = ENV["SLACK_TOKEN"]
  
  QUERY = {
    token: TOKEN}
  
  attr_reader :id, :name, :real_name
  
  def initialize(id, name, real_name)
    super(id, name)
    @real_name = real_name
  end
end




