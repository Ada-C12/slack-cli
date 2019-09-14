#lib/workspace.rb
require 'httparty'
require 'awesome_print'
require_relative "user"
require_relative "channel"

module Slack
  class  Workspace
    attr_reader :users, :channels, :recipient
    def initialize
      @users = User.users_list
      @channels = Channel.channels_list
      @recipient= nil
    end

    def select_user(input)
      found = false
      @users.each do |user|
        if user.name == input.downcase || user.id == input
          @recipient = user
          found = true
        end
      end

      if found == false
        puts "The provided name/id doesn't match any user"
        sleep(0.5)
      end
      return found
    end

    def select_channel(input)
      found = false 
      @channels.each do |channel|
        if channel.name == input.downcase || channel.id == input
          @recipient = channel
          recipient
          found = true
          break
        end
      end
      if found == false
        puts "The provided name/id doesn't match any channel"
        sleep(0.5)
      end
      return found
    end

    def show_details
      details = ""
      if @recipient != nil
        if @recipient.class == Slack::User
          details = "Name: #{@recipient.name}, Id: #{@recipient.id}, Real name: #{@recipient.real_name}\n\n"
        else 
          details = "Name: #{@recipient.name}, Id: #{@recipient.id}, Topic: #{@recipient.topic}, Member count: #{@recipient.member_count}\n\n"
        end
      else 
        details = "No recipient is currently selected."
      end
    return details
    end
  end
end 