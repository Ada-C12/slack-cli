require 'httparty'
require 'dotenv'
require 'table_print'
require 'awesome_print'
require_relative 'user'
require_relative 'channel'
require_relative 'recipient'

Dotenv.load

module SlackCLI
  class Workspace
    attr_accessor :users, :channels, :selected
    
    CHANNEL_URL = 'https://slack.com/api/channels.list'
    USER_URL = 'https://slack.com/api/users.list'
    POST_URL = 'https://slack.com/api/chat.postMessage'
    GET_PARAMETERS = {
      token: ENV['SLACK_KEY']
    }
    
    def initialize
      @users = SlackCLI::User.json_parse(SlackCLI::User.get(USER_URL, query: GET_PARAMETERS))
      @channels = SlackCLI::Channel.json_parse(SlackCLI::Channel.get(CHANNEL_URL, query: GET_PARAMETERS))
      @selected = nil
      
      puts "Workspace loaded! #{users.length} users and #{channels.length} channels available."
    end
    
    def list_users
      users_hash_array = []
      @users.each do |user|
        user_hash = {
          "slack_id" => user.slack_id,
          "display name" => user.name,
          "real name" => user.real_name,
          "status text" => user.status_text,
          "status emoji" => user.status_emoji
        }
        users_hash_array << user_hash
      end
      tp users_hash_array
    end
    
    def list_channels
      channels_hash_array = []
      @channels.each do |channel|
        channel_hash = {
          "slack_id" => channel.slack_id,
          "name" => channel.name,
          "topic" => channel.topic,
          "member_count" => channel.member_count
        }
        channels_hash_array << channel_hash
      end
      tp channels_hash_array
    end
    
    def print_details(selected)
      if selected.class == SlackCLI::User
        user_hash = [
          {
            "slack_id" => selected.slack_id,
            "display name" => selected.name,
            "real name" => selected.real_name,
            "status text" => selected.status_text,
            "status emoji" => selected.status_emoji
          }
        ]
        tp user_hash 
      elsif selected.class == SlackCLI::Channel
        channel_hash = [
          {
            "slack_id" => selected.slack_id,
            "name" => selected.name,
            "topic" => selected.topic,
            "member_count" => selected.member_count
          }
        ]
        tp channel_hash
      else 
        print "Sorry, something went wrong."
      end 
    end
    
    def send_message(selected, msg)
      post_parameters = {
        token: ENV['SLACK_KEY'],
        channel: selected.slack_id,
        text: msg
      }
      return HTTParty.post(POST_URL, query: post_parameters)
    end
  end
end 