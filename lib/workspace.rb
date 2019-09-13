require_relative "user"
require_relative "channel"
require_relative "recipient"

class SlackApiError < StandardError; end

module Slack
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = Slack::User.list.map do |user_obj|
        Slack::User.new(name: user_obj["user name"], slack_id: user_obj["slack id"], real_name: user_obj["real name"])
      end
      @channels = Slack::Channel.list.map do |chan_obj|
        Slack::Channel.new(name: chan_obj["name"], slack_id: chan_obj["slack id"], topic: chan_obj["topic"], member_count: chan_obj["member count"])
      end
      @selected = nil
    end

    def select_channel(identifier)
      @channels.each do |channel|
        if [channel.name, channel.slack_id].include?(identifier)
          @selected = channel
          return @selected
        end
      end
      raise SlackApiError.new("[We couldn't find this channel!]")
    end

    def select_user(identifier)
      @users.each do |user|
        # if user.name == identifier
        #   @selected = user
        #   return
        # elsif user.slack_id == identifier
        #   @selected = user
        #   return
        if [user.name, user.slack_id].include?(identifier)
          @selected = user
          return @selected
        end
      end
      raise SlackApiError.new("[We couldn't find this user!]")
    end

    def show_details
      if @selected
        @selected.details
      end
    end

    def send_message(message)
      if @selected
        @selected.send_message(message)
      else
        return nil
      end
    end
  end
end
