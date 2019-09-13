require 'httparty'
require 'table_print'

require_relative 'channel'
require_relative 'user'

module SlackBot
  class Workspace
    attr_reader :users, :channels, :selected
    
    def initialize
      @users = User.list
      @channels = Channel.list
      @selected = nil
    end
    
    def select_channel(criteria)
      @channels.each do |channel|
        if channel.name == criteria.downcase
          @selected = channel
          return puts "Channel #{@selected.name} is selected"
        end
      end
      @channels.each do |channel|
        if channel.slack_id == criteria.upcase
          @selected = channel
          return puts "Channel #{@selected.name} is selected"
        end
      end
      raise ArgumentError, "Invalid Enty: No such channel."
    end
    
    def select_user(criteria)
      @users.each do |user|
        if user.name == criteria.downcase
          @selected = user
          return puts "User #{@selected.name} is selected"
        end
      end
      @users.each do |user|
        if user.slack_id == criteria.upcase
          @selected = user
          return puts "User #{@selected.name} is selected"
        end 
      end
      raise ArgumentError, "Invalid Enty: No such user."
    end
    
    def details
      if @selected.class == Channel
        tp @selected, "slack_id", "name", "topic", "member_count"
      else
        tp @selected, "slack_id", "name", "real_name"
      end
    end
    
    def send_message(slack_id:, message:)
      response = @selected.send_message(slack_id: slack_id, message: message)
      if response["ok"] == true
        puts "message sent"
      else
        puts "Failure: message did not send.".colorize(:red)
      end
    end
  end
end
