#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require 'awesome_print'
require_relative './user'
require_relative './channel'
Dotenv.load('../.env')
# require 'pry'

KEY = ENV['KEY']

# CHANNELS_URL = "https://slack.com/api/channels.list"
#  USERS_LIST = "https://slack.com/api/users.list"
#CHAT_URL = "https://slack.com/api/chat.postMessage"

def main
  # binding.pry
  users = Slack::User.list_users
  channels = Slack::Channel.list_channels
  puts "Welcome to the Ada Slack CLI!"
  puts "There are #{users.length} users and #{channels.length}."
  
  puts "Would you like to view: List Users, List Channels, or Quit?" # add number options?
  user_input = gets.chomp.split.map(&:capitalize).join(' ')
  
  while user_input != "List Users" && user_input != "List Channels" && user_input != "Quit"
    puts "\nIncorrect input!! Please select:  List Users, List Channels, or Quit"
    user_input = gets.chomp.split.map(&:capitalize).join(' ')
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
