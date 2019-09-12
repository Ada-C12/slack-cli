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
    print "\nWhat would you like to do?
    - list users
    - list channels
    - select user
    - select channel
    - show details
    - quit
    \nYour choice: "
    choice = gets.chomp.downcase
    until ["list users", "list channels", "select user", "select channel", "show details", "quit"].include?(choice)
      print "Sorry. Please enter a valid choice. "
      choice = gets.chomp.downcase
    end

    if choice == "list users"
      tsu.list_users
    elsif choice == "list channels"
      tsu.list_channels
    elsif choice == "select user"
      print "Please select a user (by Slack ID or Display Name): "
      user_chosen = gets.chomp
      if [tsu.user_menu].include?(user_chosen)
        selected = user_chosen
      else
        print "Sorry. Invalid selection."
      end
    elsif choice == "select channel"
      print "Please select a channel (by Slack ID or Name): "
      channel_chosen = gets.chomp
      if [tsu.channel_menu].include?(channel_chosen)
        selected = user_chosen
      else
        print "Sorry. Invalid selection."
      end
    elsif choice == "show details"
      if selected == nil
        puts "No user or channel chosen."
      end
      tsu.print_details(selected)
    elsif choice == "quit"
      puts "Thank you for using the Ada Slack CLI"
      exit
    end
  end
end

main

#main if __FILE__ == $PROGRAM_NAME