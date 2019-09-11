require 'httparty'
require 'awesome_print'
require_relative "user"
require_relative "channel"

module Slack
  class  Workspace
    attr_reader :users, :channels, :selected
    def initialize
      @users = User.users_list
      @channels = Channel.channels_list
      @selected = selected
    end
  end
end










   