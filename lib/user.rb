# username, real name, and Slack ID.
require "pry"
class User < Recipient
  attr_reader :real_name

  def initialize(slack_id, name, real_name)
    super(slack_id, name)
    @real_name = real_name
  end 

  def self.get(url, query)
    url = "https://slack.com/api/users.list"
    query = {token: ENV['SLACK_TOKEN']}

    response = HTTParty.get(url, query: query)
    return response
  end

  def self.list
    users_list = []
    response = User.get("https://slack.com/api/users.list", {token: ENV['SLACK_TOKEN']})
    response["members"].each do |member|
      new_user = User.new(member["id"], member["name"], member["real_name"])
      # binding.pry 
      users_list << new_user
    end
    return users_list
  end
end