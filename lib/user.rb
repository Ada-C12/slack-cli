require 'httparty'

class User < Recipient
  URL = 'https://slack.com/api/users.list'
  KEY = ENV['SLACK_API_TOKEN']

    attr_reader :slack_id, :name, :real_name
    @@users_list = []

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
      return response
    end

end