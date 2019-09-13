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
    
    def select_channel(name_or_id)
        @channels.each do |channel|
          if channel.has_value?(name_or_id)
            return channel
          end
        end  
        puts "Sorry, I couldn't find that channel."
    end
    
    def select_user(name_or_id)   
      @users.each do |user|
        if user.has_value?(name_or_id)
          return user
        end
      end  
      puts "Sorry, I couldn't find that user."
    end
           
    
    # def show_details
#     When I type details, the program should print out details for the currently selected recipient. What information is printed depends on whether it's a channel or a user.
# If no recipient is currently selected, the program should let me know and return to the main command prompt.

    # end 
    
    # def send_message
    # end 
  end 
  
end 
