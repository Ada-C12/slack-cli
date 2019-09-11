require_relative "user"
require_relative "channel"
require_relative "acceptor"

require 'awesome_print'

module Slack
  class Workspace
    USER_URL = "https://slack.com/api/users.list"
    # URL2 = 
    
    attr_reader :users, :channels, :selected

    def initialize
      @users = []
      @channels = []
      @selected = []
    end

    def get_api(url)
      query_parameters = {
        token: ENV['SLACK_TOKEN']
      }
      return HTTParty.get(url, query: query_parameters)
    end

    def user_list
      api_user_response = get_api(USER_URL)
      api_members = api_user_response["members"]
      api_members.each do |each_member|
        username = each_member["name"]
        real_name = each_member["real_name"]
        slack_id = each_member["id"]
        @users << Slack::User.new(username: username, real_name: real_name, slack_id: slack_id)
      end
    end

    def print_user_list
      user_counter = 0
      result = ''
      @users.each do |each_user|
        user_counter += 1
        result = result + "User #{user_counter} - username: #{each_user.username}, real name: #{each_user.real_name}, Slack ID: #{each_user.slack_id}\n"
      end
      return result
    end

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

# hello = Slack::Workspace.new
# hello.user_list
# puts hello.print_user_list
