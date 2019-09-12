require 'dotenv'
require "pry"
Dotenv.load

class Workspace
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
        return channel
      end
    end

    if value = 0
      raise ArgumentError.new("That is wrong") 
    end
  end 
end