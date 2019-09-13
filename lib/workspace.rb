require_relative "user"
require_relative "channel"

module Slack
  class Workspace
    attr_reader :users, :channels, :selected
    
    def initialize
      @users = User.list
      @channels = Channel.list
      @selected = []
    end
    
    # def select_channel
    # end
    
    def select_user(name_or_id)   
      @users.each do |user|
        if user.has_value?(name_or_id)
          return user
        end
      end  
      puts "Sorry, I couldn't that name or ID."
    end
        
    
    # search list of users for user name, return if match
    # search list of users for ID, return if match
    # if no match for name or ID, provide "not found" message and return to top of the loop
    
    
    # def show_details
    # end 
    
    # def send_message
    # end 
  end 
  
end 
