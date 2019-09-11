require_relative 'user'
require_relative 'channel'

class Workspace
  
  attr_reader :users, :channels, :selected
  
  def initialize
    @users = User.get
    @channels = Channel.get
    @selected = nil
    
  end
  
  def select_channel
    
  end
  
  def select_user
    
  end
  
  def show_details
    
  end
  
  def send_message
    
  end
end