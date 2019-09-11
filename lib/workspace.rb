require_relative 'user'
require_relative 'channel'
require 'dotenv'
require 'httparty'
require 'table_print'

Dotenv.load

module Slack
  class Workspace
    attr_accessor :selected
    attr_reader :users, :channels
    
    BASE_URL = "https://slack.com/api/"
    TOKEN = ENV['SLACK_TOKEN']
    
    def initialize
      @users = Slack::User.get("#{BASE_URL}/users.list", query: {token: TOKEN})
      @channels = Slack::Channel.get("#{BASE_URL}/channels.list", query: {token: TOKEN})
      @selected = nil
    end
    
    #should this be in workspace or main?
    def list_users
      tp @users, :real_name, :slack_id, :user_name => {:display_method => :name}
    end
    
    def list_channels
      tp @channels, :name, :member_count, :slack_id, :topic => {:width => 50}
    end
    
    def select_user(requested_user)
      found_user = @users.find {|user| user.name == requested_user || user.slack_id == requested_user}
      
      unless found_user == nil
        @selected = found_user
      end
      
      return found_user
    end
    
    def select_channel(requested_channel)
      found_channel = @channels.find {|channel| channel.name == requested_channel || channel.slack_id == requested_channel}
      
      unless found_channel == nil
        @selected = found_channel
      end
      
      return found_channel
    end
    
    def send_message(message)
      response = HTTParty.post(
        "#{BASE_URL}/chat.postMessage",
        body: {
          token: TOKEN,
          channel: selected.slack_id,
          text: message
        }
      )
      
      unless response.code == 200 && response["ok"]
        raise SlackApiError, "Error when sending message to #{selected.name}. Invalid API request with code #{response.code} and message #{response["error"]}."
      end
      
      return true
    end
    
    #def show_selected_details
    # end
    
  end
end

