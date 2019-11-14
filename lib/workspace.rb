require_relative 'user'
require_relative 'channel'
require_relative 'recipient'
require 'httparty'
require 'dotenv'

Dotenv.load

module Slack
  class Workspace < Recipient
    BASE_URL = "https://slack.com/api/"
    TOKEN = ENV["SLACK_TOKEN"]
    QUERY = {
      token: TOKEN
    }

    attr_reader :users, :channels
    attr_accessor :selected

    def initialize
      @users = User.list
      @channels = Channel.list
      @selected = nil
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

    def send_message(message)
      post_query = {
        token: TOKEN,
        channel: @selected[0].id,
        text: message
      }
      HTTParty.post(BASE_URL + "chat.postMessage", query: post_query)
    end
  end
end