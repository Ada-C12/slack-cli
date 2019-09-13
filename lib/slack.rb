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
    - send message
    - quit
    \nYour choice: "
    choice = gets.chomp.downcase
    until ["list users", "list channels", "select user", "select channel", "show details", "send message", "quit"].include?(choice)
      print "Sorry. Please enter a valid choice. "
      choice = gets.chomp.downcase
    end
    
    case choice
    when "list users"
      tp tsu.list_users
    when "list channels"
      tp tsu.list_channels
    when "select user"
      print "Please select a user (by Slack ID or Display Name): "
      user_chosen = gets.chomp
      puts "\nYou have selected #{tsu.select_user(user_chosen).name}"
    when "select channel"
      print "Please select a channel (by Slack ID or Name): "
      channel_chosen = gets.chomp
      puts "\nYou have selected #{tsu.select_channel(channel_chosen).name}"
    when "show details"
      if tsu.selected == nil
        puts "\nNo user or channel chosen."
      else
        tp tsu.print_details(tsu.selected)
      end
    when "send message"
      if tsu.selected == nil
        puts "\nNo user or channel chosen."
      else
        print "What is your message? "
        msg = gets.chomp
        tsu.send_message(tsu.selected, msg)
      end
    when "quit"
      puts "Thank you for using the Ada Slack CLI"
      exit
    end
  end
end

main

#main if __FILE__ == $PROGRAM_NAME