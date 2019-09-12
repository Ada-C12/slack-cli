#!/usr/bin/env ruby
require "httparty"
require "dotenv"
Dotenv.load

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
      # call list method
      puts "this is answer 1"
    elsif user_answer == 2
      # call user method
      puts "this is answer 2"
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