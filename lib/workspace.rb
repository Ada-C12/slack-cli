require 'httparty'
require 'dotenv'
require_relative 'user'
require_relative 'channel'

Dotenv.load

module SlackCLI
  class Workspace
    CHANNEL_URL = 'https://slack.com/api/channels.list'
    USER_URL = 'https://slack.com/api/users.list'
    query_parameters = {
      token: ENV['SLACK_KEY']
    }
    attr_accessor :users, :channels, :selected
    def initialize
      @users = []
      @channels = Channel.get(CHANNEL_URL, query_parameters).json_parse
      @selected = nil
    end
  end
end
