require_relative 'channel'
require_relative 'user'
require_relative 'slack_api_error'
require "pry"
module Slack
  
  class Workspace
    attr_reader :users, :channels, :selected
    
    def initialize
      @users = Slack::User.list
      @channels = Slack::Channel.list
      @selected = nil
    end
    
    def select_user(username: nil, id: nil)
      
      if username == nil && id == nil
        raise Slack::Slack_Api_Error.new "Error! You must enter either a valid username or ID."
      end
      
      selected_user = @users.find do |user|
        user.name == username || user.id == id
      end
      
      if selected_user == nil
        raise ArgumentError.new "Error! The user you searched for does not exist."
      end
      
      @selected = selected_user
      return @selected
    end
    
    def select_channel(channel_name: nil, id: nil)
      
      raise Slack::Slack_Api_Error.new("Error! You must enter either a valid channel name or ID.") if channel_name.nil? && id.nil?
      selected_channel = @channels.find {|channel| channel.name == channel_name || channel.id == id}
      
      raise ArgumentError.new("Error! The channel you searched for does not exist") if selected_channel.nil?
      
      @selected = selected_channel
      return @selected
      
    end

    def show_details
      
      if @selected == nil
        raise Slack::Slack_Api_Error.new "Error! You must first select a recipient."
      else
        return @selected.details
      end

    end
    
  end
end 

