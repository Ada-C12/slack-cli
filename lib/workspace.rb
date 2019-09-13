require_relative 'user'
require_relative 'channel'

module Slack
  class Workspace
    
    attr_reader :users, :channels, :selected
    
    def initialize
      @users = User.list
      @channels = Channel.list
      @selected = nil
    end
    
    def select_user_slack_id(slack_id: nil)
      user_object = @users.find { |user| user.slack_id == slack_id }
      @selected = user_object unless user_object.nil?
    end
    
    def select_user_username(user_name: nil)
      user_object = @users.find { |user| user.name == user_name }
      @selected = user_object unless user_object.nil?
    end
    
    def select_channel_slack_id(slack_id: nil)
      channel_object = @channels.find { |channel| channel.slack_id == slack_id }
      @selected = channel_object unless channel_object.nil?
    end
    
    def select_channel_username(user_name: nil)
      channel_object = @channels.find { |channel| channel.name == user_name }
      @selected = channel_object unless channel_object.nil?
    end
    
    
    def show_details
      @selected.details.each do |detail, value|
        puts "#{detail}: #{value}"
      end
    end
    
    def send_message(message)
      @selected.send_msg(message)
    end
    
  end
end 