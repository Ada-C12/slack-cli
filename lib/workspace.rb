require_relative 'channel'
require_relative 'user'
require_relative 'slack'
require 'dotenv'

Dotenv.load

class Workspace
  attr_reader :users, :channels, :selected
  KEY = ENV['SLACK_TOKEN']
  
  def initialize
    @users = User.list
    @channels = Channel.list
    @selected = nil
  end
  
  
  def select_channel(selection)
    @selected = @channels.find do |channel|
      channel.name == selection || channel.slack_id == selection.upcase
    end
    
  end
  
  
  def select_user(selection)
    @selected = @users.find do |user|
      user.user_name == selection || user.slack_id == selection.upcase
    end
  end
  
  
  
  def show_details
    if @selected != nil
      if @selected.class == Channel
        return @selected
      elsif @selected.class == User
        return @selected
      end
    else
      return nil
    end
    
  end
  
  
  def send_message(message, channel)
    response = HTTParty.post("https://slack.com/api/chat.postMessage", 
      body: {
        token: ENV["SLACK_TOKEN"],
        channel: channel,
        text: message
      },
      headers: { 'Content-type' => 'application/x-www-form-urlencoded' }
    )
  end
  
end


# a = Workspace.new
# a.select_channel("general")
# p a.show_details
# p a.selected
