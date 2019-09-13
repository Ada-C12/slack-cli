require_relative "user"
require_relative "channel"

module Slack
  class Workspace
    attr_reader :users, :channels, :selected
    
    def initialize
      @users = User.list
      @channels = Channel.list
      @selected = nil
    end
    
    def select_channel(name_or_id)
      @channels.each do |channel|
        if channel.name == name_or_id || channel.slack_id == name_or_id
          @selected = channel
          return "Channel #{@selected.name} is selected."
        end
      end  
      puts "Sorry, I couldn't find that channel."
    end
    
    def select_user(name_or_id)
      @users.each do |user|
        if user.name == name_or_id || user.slack_id == name_or_id
          @selected = user
          return "User #{@selected.name} is selected."
        end
      end  
      puts "Sorry, I couldn't find that user."
    end
    
    def show_details
      @selected.details
    end
    
    def send_message
      
    end 
  end 
  
end 
end 
