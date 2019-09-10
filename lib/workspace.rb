require_relative 'user'
require_relative 'channel'
require 'dotenv'
require 'httparty'
require 'table_print'

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
      tp @users, :real_name, :slack_id, :user_name => {:display_method => :name}
      
    end
    
    def list_channels
      
      tp @channels, :name, :member_count, :slack_id, :topic => {:width => 50}
      
    end
  end
end

