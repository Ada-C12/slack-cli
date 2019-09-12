require 'httparty'
require 'dotenv'
Dotenv.load
require 'pry'

class User < Recipient
  attr_reader :slack_id, :name, :real_name
  @@users_list = []
  BASE_URL = "https://slack.com/api/users.list"
  API_KEY = ENV['SLACK_API_TOKEN']
  
  def initialize(slack_id, name, real_name)
    super(slack_id, name) 
    @real_name = real_name
    @@users_list << self
  end
  
  def self.list
    query = {
      token: API_KEY
    }
    response = HTTParty.get(BASE_URL, query: query)
    return response
  end
  
  def printed_channels_list
    users_array = []

    self.list["members"].each do |member|
      users_array << member["name"]
    end

    return users_array
  end

end