require_relative 'Recepient'

module Slack
  class Workspace 
    attr_reader :users, channels:
    def initialize
    @users = []
    @channels = []

