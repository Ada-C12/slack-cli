#lib/user.rb
require 'httparty'
require 'awesome_print'
require 'dotenv'
require_relative "user"
require_relative "recipient"
Dotenv.load

module Slack
  USERS_URI = 'https://slack.com/api'
  USERS_KEY = ENV['API_KEY']
  class  User < Recipient
    attr_reader :real_name
    def initialize(name, id, real_name)
      super(name, id)
      @real_name = real_name
    end
 
    def self.users_list
      users = []
      response = HTTParty.get("#{USERS_URI}/users.list", query: {token: USERS_KEY}) 
      response.parsed_response["members"].each do |member|
        name =  member["name"]
        id =  member["id"]
        real_name = member["real_name"]
        user = Slack::User.new(name, id, real_name)  
        users  << user  
      end
      return users
    end
    
  end
end

