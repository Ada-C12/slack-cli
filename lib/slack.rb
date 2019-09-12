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
  
  loop do 
    print "Would you like to (1) list users, (2) list channels, or (3) quit? "
    choice = gets.chomp.to_i
    until [1, 2, 3].include?(choice)
      print "Sorry. Please enter '1', '2' or '3'!"
      choice = gets.chomp
    end
    if choice == 1
      tsu.list_users
    elsif choice == 2
      tsu.list_channels
    elsif choice == 3
      puts "Thank you for using the Ada Slack CLI"
      exit
    end
  end 
end

main

#main if __FILE__ == $PROGRAM_NAME