#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'


require_relative 'recipient.rb'
require_relative 'channel.rb'
require_relative 'user.rb'

# Tell dotenv to look for the .env file
Dotenv.load

URL =	"https://slack.com/api/channels.list"
KEY = ENV['SLACK_TOKEN']

def main
  while true
    puts "Welcome to the Ada Slack CLI!"
    puts "Select an option: list users, list channels or quit"
    
    option = gets.chomp

    break if option.downcase == 'quit'

    if option.downcase == 'list users'
       puts User.list

    elsif option.downcase == 'list channels'
      puts Channel.list
    end

  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME