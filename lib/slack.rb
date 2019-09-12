#!/usr/bin/env ruby
require "httparty"
require_relative "channel"
require_relative "user"
require "dotenv"
Dotenv.load
require 'table_print'

def main
  puts"Welcome to the Ada Slack CLI!"
  puts"Select an option by number:"
  options_array=["List Channels","List Users","Quit"]
  options_array.each_with_index{ |channel, index|
    puts"#{index+1}.#{channel}"
  }
  
  user_answer = gets.chomp.to_i
  
  while user_answer != 3
    if user_answer == 1
      Channel.printed_channels_list
    elsif user_answer == 2
      User.printed_users_list
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