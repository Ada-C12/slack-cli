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

  attr_reader :users, :channels
  attr_accessor :selected

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
    tp @users, :id, :name, :real_name
    puts "\n\n"
  end

  def display_channels
    tp @channels, :id, :name, :topic, :member_count
    puts "\n\n"
  end

  def select_user(user_input)
    @selected = users.select { |user| user.name == user_input || user.id == user_input }
  end

  def select_channel(user_input)
    @selected = channels.select { |channel| channel.name == user_input || channel.id == user_input }
  end

  def show_details
    tp @selected
  end

  def send_message
  end
end