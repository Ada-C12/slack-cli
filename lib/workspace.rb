require_relative 'user'
require_relative 'channel'

module SlackCLI
  class Workspace
    attr_reader :users, :channels
    attr_accessor :selected
    
    def initialize
      @users = SlackCLI::User.list
      @channels = SlackCLI::Channel.list
      @selected = nil
    end
    
    def find_instance(recipient_list, name_or_id)
      instance = recipient_list.find do |recipient|
        recipient.name.downcase == name_or_id.downcase || 
        recipient.slack_id.downcase == name_or_id.downcase        
      end
      
      return instance
    end
    
    def select_user(name_or_id)
      user = find_instance(users, name_or_id)
      @selected = user if user != nil

      return @selected
    end
    
    def select_channel(name_or_id)
      channel = find_instance(channels, name_or_id)
      @selected = channel if channel != nil
      
      return @selected
    end
    
    def show_details
      selected ? selected.details : nil
    end

    def send_message
      if @selected == nil
        return nil
      else
        puts "Send Message to '#{@selected.name}'"
        print "Please enter message text: "
        message_text = gets.chomp
        @selected.send_message(message_text)
        return true
      end
    end
  end

end
