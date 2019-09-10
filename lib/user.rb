require_relative 'Recepient'

module Slack
  class User
    attr_reader slack_id:, name:, user_name:
    
    def initialize(slack_id, name, user_name)
      @slack_id = slack_id
      @name = name
      @user_name = user_name

      def self.list_users
    USERS_LIST = "https://slack.com/api/users.list"
    query = {
      token: ENV['USERS_LIST']
    }
    response = HTTParty.get(USERS_LIST, query: query)
members = response[:members]

    users = []
    members.each do |user_hash|
      slack_id = user_hash["slack_id"]
      name = user_hash["name"]
      user_name = user_hash["user_name"]
      users << User.new(user_name, name, slack_id)
    end

    return users
  end 

      