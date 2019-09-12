require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load 

require_relative 'recipient'

module SlackCli
  class User < Recipient
    attr_reader :name, :real_name, :id

    def initialize(name:, real_name:, id:)
      @real_name = real_name
      @name = name
      @id = id 
    end 

    def self.list
      method_url = "https://slack.com/api/users.list"
      query_params = {
        token: ENV["SLACK_TOKEN"]
      }
      response = HTTParty.get(method_url, query: query_params)
    
      users = response.parsed_response["members"]
      i = 0
      all_users = []
      users.each do |user|
        user_hash = {}
        user_name = response.parsed_response["members"][i]["name"]
        real_name = response.parsed_response["members"][i]["real_name"]
        id = response.parsed_response["members"][i]["id"]
        user_hash[:user_name] = user_name
        user_hash[:real_name] = real_name
        user_hash[:id] = id
        all_users.push(user_hash)
        i += 1
      end 
      ap all_users
    end 
  end 
end 