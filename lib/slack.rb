#!/usr/bin/env ruby
require 'httparty'
require 'dotenv'
require_relative 'user'
require_relative 'channel'
require_relative 'workspace'

Dotenv.load

def invalid_input_check(input)
  if input == nil
    print "\nSorry. Invalid selection."
    return true 
  else 
    puts "\n#{input.name} has been selected."
  end 
end 

def selected_is_nil(selected)
  if selected == nil
    puts "\nNo user or channel selected."
    return true
  end 
end 

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
      print "\nSorry. Please enter a valid choice. "
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
      tsu.selected = tsu.select_user(user_chosen)
      invalid_input_check(tsu.selected)
    when "select channel"
      print "Please select a channel (by Slack ID or Name): "
      channel_chosen = gets.chomp
      tsu.selected = tsu.select_channel(channel_chosen)
      invalid_input_check(tsu.selected)
    when "show details"
      if !selected_is_nil(tsu.selected)
        tp tsu.print_details(tsu.selected)
      end 
    when "send message"
      if !selected_is_nil(tsu.selected)
        print "What is your message? "
        msg = gets.chomp
        tsu.selected.send_message(msg)
      end
    when "quit"
      puts "Thank you for using the Ada Slack CLI"
      exit
    end
  end
end

main

#main if __FILE__ == $PROGRAM_NAME
