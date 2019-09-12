#!/usr/bin/env ruby
require "httparty"
require_relative "channel"
require_relative "user"
require "dotenv"
Dotenv.load
require 'table_print'
require 'pry'

def main
  puts"Welcome to the Ada Slack CLI!"
  puts"Select an option by number:"
  options_array=["List Channels","List Users","Select User","Select Channel","Quit"]
  options_array.each_with_index{ |channel, index|
    puts"#{index+1}.#{channel}"
  }
  
  user_answer = gets.chomp.to_i
  
  while user_answer != 5
    if user_answer == 1
      Channel.printed_channels_list
    elsif user_answer == 2
      puts User.printed_users_list
    elsif user_answer == 3
      puts User.printed_users_list
      puts "Please enter a username or Slack ID:"
      desired_person = gets.chomp
      puts User.select_user_details(desired_person)
    elsif user_answer == 4      
      Channel.printed_channels_list
      puts "Please enter a channel name or Slack ID"
      desired_channel = gets.chomp
      puts Channel.select_channel_details(desired_channel)
    end
    
    puts "Select an option by number:"
    options_array.each_with_index { |channel,index|
      puts "#{index+1}.#{channel}"
    }
    user_answer = gets.chomp.to_i
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME