require 'httparty'
require 'dotenv'
require_relative 'user'
require_relative 'channel'

Dotenv.load
attr_accessor :users, :channels, :selected
def initialize
  @users = []
  @channels = Channel.get(url: ).list
  @selected = nil
end
