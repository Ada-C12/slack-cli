require_relative "user"
require_relative "channel"
require_relative "acceptor"

module Slack
  class Workspace
    # attr_reader
    def initialize
      @users = []
      @channels = []
      @selected = []
    end

    # call user api method - OR MAYBE NOT B/C LIST CALLS GET_API
      # TO-DO: should we make get_api a class method in User?
      # TO-DO: decide on how this interacts with the CLI
    # call user list method
    users = Workspace::User.list #store the return value of .list inside of the users 
    # iterate through users and call instance variables on user
      # for each user in users, puts user.username, user.real_name, user.slack_id
    # end

    # def select_user
      # code
    # end

    # def select_channel
      # code
    # end

    # def show_details
      # code
    # end

    # def send_message
      # code
    # end

  end 
end 