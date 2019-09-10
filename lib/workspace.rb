module SlackCLI
  class Workspace
    
    attr_reader :users, :channels, :selected
    
    def initialize
      @users = SlackCLI::User.all
      @channels = SlackCLI::Channel.all
      @selected = nil
    end
    
    
    
  end
  
  
  
end
