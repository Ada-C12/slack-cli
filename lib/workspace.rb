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
    
    def select(name_or_id)
      @channels.each do |channel|
        if channel.name == name_or_id || channel.slack_id == name_or_id
          @selected = channel
          return "Okay, #{@selected.name} is selected."
        else 
          @users.each do |user|
            if user.name == name_or_id || user.slack_id == name_or_id
              @selected = user
              return "Okay, #{@selected.name} is selected." 
            end
          end
        end  
      end
      puts "Sorry, I couldn't find that user or channel."
    end
        
    def show_details
      @selected.details
    end
    
    def user_message(message, slack_id)
      @selected.send_message(@selected.slack_id, message)
      return puts "Success! Message sent to #{@selected.name}."      
    end 
    
  end
end
