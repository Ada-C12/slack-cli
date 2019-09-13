require_relative 'user'
require_relative 'channel'
require 'dotenv'
require 'httparty'
require 'table_print'

Dotenv.load

module Slack
  class Workspace
    attr_reader :users, :channels, :selected
    
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
      found_user = @users.find do |user| 
        user.name == requested_user || user.slack_id == requested_user
      end
      
      @selected = found_user unless found_user == nil
      
      return found_user
    end
    
    def select_channel(requested_channel)
      found_channel = @channels.find do |channel| 
        channel.name == requested_channel || channel.slack_id == requested_channel
      end
      
      @selected = found_channel unless found_channel == nil
      
      return found_channel
    end
    
    def send_message(message)
      response = HTTParty.post( "#{BASE_URL}/chat.postMessage", body: { token: TOKEN, channel: selected.slack_id, text: message } )
      
      unless response.code == 200 && response["ok"]
        raise SlackApiError, "Error when sending message to #{selected.name}. Invalid API request with code #{response.code} and message #{response["error"]}."
      end
      
      return true
    end
    
    def set_profile_name(user_name)
      temp_name = @selected.name unless @selected == nil
      
      profile_settings = { token: TOKEN, profile: {"real_name": user_name} }
      response = HTTParty.post( "#{BASE_URL}/users.profile.set", headers: { "Content-Type" => "application/json", authorization: "Bearer #{TOKEN}" }, body: profile_settings.to_json )
      
      unless response.code == 200 && response["ok"]
        raise SlackApiError, "Error: invalid API request with code #{response.code} and message #{response["error"]}."
      end
      
      # reassign users and selected after changing profile information
      @users = Slack::User.get( "#{BASE_URL}/users.list", query: { token: TOKEN } )
      @selected = select_user(temp_name)
      
      puts "Profile name was changed to #{user_name}."
      return true
    end
    
    def set_profile_emoji(status_emoji)
      temp_name = @selected.name unless @selected == nil
      
      profile_settings = { token: TOKEN, profile: { "status_emoji": status_emoji } }
      
      response = HTTParty.post( "#{BASE_URL}/users.profile.set", headers: { "Content-Type" => "application/json", authorization: "Bearer #{TOKEN}" }, body: profile_settings.to_json )
      
      if response.code == 200 && response["error"] == "profile_status_set_failed_not_emoji_syntax" || response["error"] == "profile_status_set_failed_not_valid_emoji"
        puts "Invalid slack emoji."
      elsif response.code == 200 && response["ok"] == false
        raise SlackApiError, "Error: invalid API request with code #{response.code} and message #{response["error"]}."
      else
        puts "Status emoji was changed."
        
        # reassign users and selected after changing profile information
        @users = Slack::User.get("#{BASE_URL}/users.list", query: {token: TOKEN})
        @selected = select_user(temp_name)
      end
      
      return true
    end
  end
end

