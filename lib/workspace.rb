require_relative 'user'
require_relative 'channel'

module Slack
  class Workspace
    
    attr_reader :users, :channels, :selected
    
    def initialize(users, channels, selected)
      @users = users
      @channels = channels
      @selected = selected
    end
    
    def select_user(user_name: nil, slack_id: nil)
      #returns the user object that goes with passed in user_name?
      
      # error when no user exists
      
    end
    
    def select_channel(user_name: nil, slack_id: nil)
      #returns the user object that goes with passed in user_name?
      
      # error when no user exists
      
    end
    
    def show_details
    end
    
    def send_message
    end
    
  end
end 