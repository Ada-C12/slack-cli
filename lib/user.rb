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
        token: KEY
      }
      response = HTTParty.get(URL, query: query)
      
      users_names = []
      response["members"].each do |member|
        users_names_array << member["name"]
      end
      return users_names
    end

end