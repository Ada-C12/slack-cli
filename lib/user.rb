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
    token: TOKEN
    }
  
  attr_reader :id, :name, :real_name
  
  def initialize(id, name, real_name)
    super(id, name)
    @real_name = real_name
  end

  def self.list #list of users
    
    response = self.get(BASE_URL, query: QUERY)

    # iterate through response["members"]
    response["members"].map do |member|
      self.new(member["id"], member["name"], member["real_name"])
    end
    # return response
  end

  def details
    p "ID: #{id}"
  #  tp User.all
  end

end

# user = User.new("USLACKBOT", "slackbot", "Slackbot" )
# user.details


