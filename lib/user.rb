require_relative 'recipient'
require 'httparty'
require 'dotenv'
require 'table_print'
require 'pry'

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

  # def self.list #list of Users
    
    

  #   # iterate through response["members"]
   
  #   end
  #   return users
  # end

  def details
    # p "ID: #{id}"
  #  tp User.list
  end
  # binding.pry


end




