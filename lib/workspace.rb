require_relative "user"
require_relative "channel"
require_relative "recipient"

module Slack
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = users
      @channels = channels
      @selected = selected
    end

    def select_channel
    end

    def select_user
      user_list = Slack::User.list
      user_list.each do |user|
      end
    end

    def show_details
    end

    def send_message
    end
  end
end
