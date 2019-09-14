require_relative 'channel'
require_relative 'user'
require_relative 'slack'
require "table_print"
require 'pry'


class Workspace
  attr_reader :users, :channels, :selected
  
  def initialize
    @users = User.list
    @channels = Channel.list
    @selected = nil
  end
  
  
  def select_channel(selection)

      
    end
    
    
    def select_user(selection)
      @selected = @users.find do |user|
        user.user_name == selection || user.slack_id == selection
      end
      
    end
    
    
    
    def show_details
      
      
    end
    
    
    def send_message
      
      
      
    end
    
  end
  
  
  a = Workspace.new
  p a.select_user("erika.maust")
  # p a.selected
  