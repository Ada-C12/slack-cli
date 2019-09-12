require "dotenv"
require "httparty"
Dotenv.load

require_relative "recipient"
require_relative "channel"
require_relative "user"

class Workspace
  TOKEN = ENV["SLACK_TOKEN"]

  def initialize
    @channel_url = "https://slack.com/api/conversations.list"
    @user_url = "https://slack.com/api/users.list"
    @message_url = "https://slack.com/api/chat.postMessage"
    @channel_member_url = "https://slack.com/api/conversations.members"
    @users = get_users
    @channels = get_channels
  end

  def get_users
    User.load_all(@user_url, TOKEN)
  end

  def get_channels
    Channel.load_all(@channel_url, TOKEN)
  end

  def find_by_id(id)
  end

  def list_users
    user_list = HTTParty.get(@user_url, query: { token: TOKEN })
    user_list["members"].map do |user|
      "ID: #{id = user["id"]}
      Username: #{username = user["name"]}
       Name: #{real_name = user["real_name"]}"
    end
  end

  def list_channels
    channel_list = HTTParty.get(@channel_url, query: { token: TOKEN })
    channel_list["channels"].map do |channel|
      "ID: #{id = channel["id"]} 
      Name: #{name = channel["name"]} 
      Topic: #{topic = channel["topic"]["value"]} 
      Member Count: #{member_count = channel["num_members"]}"
    end
  end
end
