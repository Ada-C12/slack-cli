require_relative 'channel'
require "table_print"

class Workspace
  attr_reader :users, :channel, :selected
  
  def initialize
    @users = users
    @channel = channel
    @selected = selected
    
  end
  
  
  def select_channel
    tp Channel.list, :slack_id, :name, :topic, :member_count
    
  end
  
  
  def select_user
    
    
  end
  
  
  def show_details
    
    
  end
  
  
  def send_message
    
    
    
  end
  
  
end


p Workspace.new.select_channel