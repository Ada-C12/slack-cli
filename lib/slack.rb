#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require_relative 'user'
require_relative 'channel'
require_relative 'workspace'

Dotenv.load
def main
  puts "Welcome to the Ada Slack CLI!"
  tsu = SlackCLI::Workspace.new
  print "Would you like a list of (1) users or (2) channels? "
  choice = gets.chomp.to_i
  until [1, 2].include?(choice)
    print "Sorry. Please enter '1' or '2'!"
    choice = gets.chomp
  end
  
  if choice == 1
    tsu.list_users
  elsif choice == 2
    tsu.list_channels
  end
  
  puts "Thank you for using the Ada Slack CLI"
end

main

#main if __FILE__ == $PROGRAM_NAME