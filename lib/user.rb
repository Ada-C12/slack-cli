require 'httparty'
require 'awesome_print'
require 'dotenv'

Dotenv.load

module SlackCLI
  class User < Recipient
    attr_reader :real_name

    def initialize(slack_id:, name:, real_name:)
      super(slack_id: slack_id, name: name)
      @real_name = real_name
    end

    def self.list
      # Call the API to get users
      url = "https://slack.com/api/users.list"
      key = ENV["API_TOKEN"]

      query = {
        token: key
      }

      response = HTTParty.get(url, query: query)

      users = response["members"].map do |member|
        # pull ID, Name, and Real Name
        slack_id = member["id"]
        name = member["name"]
        real_name = member["real_name"]
          
        # for each user, inititialize User with those things
        SlackCLI::User.new(slack_id: slack_id, name: name, real_name: real_name)
      end

      return users

    end
    
  end
end
