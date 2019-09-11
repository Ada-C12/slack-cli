# require 'dotenv' 
# require 'awesome_print'
# require 'httparty'

# Dotenv.load

module Slack
  class User
    attr_reader :username, :real_name, :slack_id

    def initialize(username:, real_name:, slack_id:)
      @username = username
      @real_name = real_name
      @slack_id = slack_id
    end

    URL = "https://slack.com/api/users.list"

    def self.get_api
      query_parameters = {
        token: ENV['SLACK_TOKEN']
      }
      return HTTParty.get(URL, query: query_parameters)
    end

    def self.list
      all_users = []
      api_members = self.get_api["members"]
      api_members.each do |each_member|
        username = each_member["name"]
        real_name = each_member["real_name"]
        slack_id = each_member["id"]
        all_users << Slack::User.new(username: username, real_name: real_name, slack_id: slack_id)
      end
      return all_users
    end

    # def print_list
    #   all_users = self.list
    #   user_counter = 0
    #   result = nil
    #   all_users.each do |each_user|
    #     user_counter += 1
    #     result = result + "User #{user_counter} - username: #{each_user.username}, real name: #{each_user.real_name}, Slack ID: #{each_user.slack_id}\n"
    #     print result
    #   end
    #   return result
    # end
  end
end

# user = Slack::User.new(username: "spengler", real_name: "Bob Spengler", slack_id: "W012A3CDE")
# ap user.list

