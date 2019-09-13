require 'dotenv'
require "pry"
Dotenv.load

class Workspace
  attr_reader :users, :channels
  attr_accessor :selected 
  def initialize(users, channels, selected: nil)
    @users = users
    @channels = channels
    @selected = selected 
  end

  def select_channel(selection)
    value = 0

    Channel.list.each do |channel|
      if channel.name == selection || channel.slack_id == selection
        value = 1
        @selected = channel
        return channel
      end
    end

    if value = 0
      raise ArgumentError.new("Please provide a valid selection for channel. ") 
    end
  end 

  def select_user(selection)
    value = 0

    User.list.each do |user|
      if user.name == selection || user.slack_id == selection
        value = 1
        @selected = user 
        return user
      end
    end

    if value = 0
      raise ArgumentError.new("Please provide a valid selection for user.") 
    end
  end 
end