#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
Dotenv.load('../.env')
require 'awesome_print'
KEY = ENV['KEY']

CHANNELS_URL = "https://slack.com/api/channels.list"
USERS_LIST = "https://slack.com/api/users.list"
#CHAT_URL = "https://slack.com/api/chat.postMessage"

def main
  puts "Welcome to the Ada Slack CLI!"
  
  puts "Would you like to view: List Users, List Channels, or Quit?" # add number options?
  user_input = gets.chomp.split.map(&:capitalize).join(' ')

  while user_input != "List Users" && user_input != "List Channels" && user_input != "Quit"
    puts "\nIncorrect input!! Please select:  List Users, List Channels, or Quit"
    user_input = gets.chomp.split.map(&:capitalize).join(' ')
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
