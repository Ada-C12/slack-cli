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

    def select_user(identifier)
      @users.each do |user|
        # if user.name == identifier ||
        #   @selected = user
        #   return
        # elsif user.slack_id == identifier
        #   @selected = user
        #   return
        if [user.name, user.slack_id].include?(identifier)
          @selected = user
          return
        end
      end
      raise StandardError, "This user does not exist"
    end

    def show_details
    end

    def send_message
    end
  end
end
