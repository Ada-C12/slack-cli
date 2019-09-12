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
      print "Sorry. Please enter '1', '2' or '3'! "
      choice = gets.chomp.to_i
    end

    if choice == 1
      tsu.list_users
      print "Please select a user (by Slack ID or Display Name): "
      user_chosen = gets.chomp
      if [tsu.user_menu].include?(user_chosen)
        tsu.print_details(user_chosen)
      else
        print "Sorry. Invalid selection."
      end
    elsif choice == 2
      tsu.list_channels
      print "Please select a channel (by Slack ID or Name): "
      channel_chosen = gets.chomp
      if [tsu.channel_menu].include?(channel_chosen)
        tsu.print_details(channel_chosen)
      else
        print "Sorry. Invalid selection."
      end
    elsif choice == 3
      puts "Thank you for using the Ada Slack CLI"
      exit
    end
  end
end

main

#main if __FILE__ == $PROGRAM_NAME