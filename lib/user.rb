# username, real name, and Slack ID.
require "pry"
require 'dotenv'
Dotenv.load


class User < Recipient
  attr_reader :real_name

  def initialize(slack_id, name, real_name)
    super(slack_id, name)
    @real_name = real_name
  end 

  def self.list
    url = "https://slack.com/api/users.list"
    query = {token: ENV['SLACK_TOKEN']}

    users_list = []
    response = Recipient.get(url, query)
    response["members"].each do |member|
      new_user = User.new(member["id"], member["name"], member["real_name"])
      users_list << new_user
    end
    return users_list
  end

  def details
    return {slack_id: @slack_id, name: @name, real_name: @real_name}
  end

end