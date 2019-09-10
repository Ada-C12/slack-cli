require 'httparty'
require 'awesome_print'
require 'pry'
require 'table_print'
require 'dotenv'
Dotenv.load

require_relative 'slack_api_error'
require_relative 'recipient'
require_relative 'channel'
require_relative 'user'

class Workspace
  attr_reader :users, :channels, :selected
  
  def initialize
    @users = User.list
    @channels = Channel.list 
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
