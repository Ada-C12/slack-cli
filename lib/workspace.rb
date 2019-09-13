require_relative 'channel'
require_relative 'user'
require_relative 'slack'
require "table_print"


class Workspace
  attr_reader :users, :channels, :selected
  
  def initialize
    @users = User.list
    @channels = Channel.list
    @selected = nil
  end
  
  
  def select_channel(selection)
    # tp Channel.list, :slack_id, :name, :topic, :member_count
    
  end
  
  
  def select_user
    
    
  end
  
  
  def show_details
    
    
  end
  
  
  def send_message
    
    
    
  end
  
  
end
