module SlackCLI
  class Workspace
    
    attr_reader :users, :channels, :selected
    
    def initialize
      @users = SlackCLI::User.all
      @channels = SlackCLI::Channel.all
      @selected = nil
    end
    
    def find_user(search_term)
      found_user = users.find do |user|
        user.name == search_term.downcase || user.slack_id == search_term.upcase
      end
      
      if found_user
        @selected = found_user
      else
        @selected = nil
      end
      
      return selected
    end
    
    def find_channel(search_term)
      
      found_channel = channels.find do |channel|
        channel.name == search_term.downcase || channel.slack_id == search_term.upcase
      end
      
      if found_channel
        @selected = found_channel
      else
        @selected = nil
      end
      
      return selected
    end
  end
end
