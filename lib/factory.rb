require "dotenv"
require "httparty"
Dotenv.load

class Factory
  TOKEN = ENV["SLACK_TOKEN"]

  def initialize
    @channel_url = "https://slack.com/api/conversations.list"
    @user_url = "https://slack.com/api/users.list"
    @message_url = "https://slack.com/api/chat.postMessage"
    @channel_member_url = "https://slack.com/api/conversations.members"
  end

  def list_users
    user_list = HTTParty.get(@user_url, query: { token: TOKEN })
    user_list["members"].map do |user|
      "ID: #{id = user["id"]} Username: #{username = user["name"]} Name: #{real_name = user["real_name"]}"
    end
  end
end
