require_relative "user"
require_relative "channel"
require_relative "recipient"

module Slack
  class Workspace
    attr_reader :users, :channels, :selected

    def initialize
      @users = Slack::User.list.map do |user_obj|
        Slack::User.new(name: user_obj["user name"], slack_id: user_obj["slack id"], real_name: user_obj["real name"])
      end
      @channels = nil
      @selected = nil
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
