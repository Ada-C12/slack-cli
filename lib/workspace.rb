require_relative 'user'
require_relative 'channel'
require_relative 'recipient'
require 'httparty'
require 'dotenv'
require 'pry'

Dotenv.load

class Workspace < Recipient
  BASE_URL = "https://slack.com/api/"
  TOKEN = ENV["SLACK_TOKEN"]
  
  QUERY = {
    token: TOKEN}

  attr_reader :users, :channels, :selected

  def initialize
    @users = self.get_users
    @channels = self.get_channels
    @selected = nil
  end

  def get_users
    response = self.get(BASE_URL + "users.list", query: QUERY)

    users = response["members"].map do |member|
      User.new(member["id"], member["name"], member["real_name"])
    end

    return users

  end

  def get_channels
    response = self.get(BASE_URL + "channels.list", query: QUERY)

    channels = response["channels"].map do |channel|
      Channel.new(channel["id"], channel["name"], channel["topic"]["value"], channel["num_members"])
    end

    return channels

  end

  def display_users
    return tp @users, :id, :name, :real_name
  end

  def display_channels
    return tp @channels, :id, :name, :topic, :member_count
  end

  def select_channel
  end

  def select_user
  end

  def show_details
  end

  def send_message
  end
end