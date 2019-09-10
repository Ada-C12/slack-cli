require_relative 'user'
require_relative 'channel'
require 'dotenv'
require 'httparty'

Dotenv.load

module Slack
  class Workspace
    attr_reader :users, :channels, :selected
    
    CHANNELS_URL = "https://slack.com/api/channels.list"
    USERS_URL = "https://slack.com/api/users.list" 
    TOKEN = ENV['SLACK_TOKEN']
    
    def initialize
      @users = Slack::User.get(USERS_URL, query: {token: TOKEN})
      @channels = Slack::Channel.get(CHANNELS_URL, query: {token: TOKEN})
      @selected = nil
    end
    
    def list_users
      @users.each do |user|
        puts "User name: #{user.name}, Real name: #{user.real_name}, Slack ID: #{user.slack_id}"
      end
    end
    
    def list_channels
      @channels.each do |channel|
        puts "Channel name: #{channel.name}, Topic: #{channel.topic}, Member count: #{channel.member_count}, Slack ID: #{channel.slack_id}"
      end
    end
  end
end

