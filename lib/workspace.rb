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
    # end 
    
    def get_api
      URL = "https://slack.com/api/users.list"
      query_parameters = {
        token: ENV['SLACK_TOKEN']
      }
      return HTTParty.get(URL, query: query_parameters)
    end

    def user_list
      api_members = self.get_api["members"]
      api_members.each do |each_member|
        username = each_member["name"]
        real_name = each_member["real_name"]
        slack_id = each_member["id"]
        @users << Slack::User.new(username: username, real_name: real_name, slack_id: slack_id)
      end
    end

    # call user list method
    # users = Slack::User.list #store the return value of .list inside of the users 
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