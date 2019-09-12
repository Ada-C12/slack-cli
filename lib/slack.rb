require 'httparty'
require  'dotenv'

Dotenv.load

# !/usr/bin/env ruby

def main
  
  
  puts "Welcome to the Ada Slack CLI!"
  
  # TODO project
  puts "Please select one of the following: \'list user\', \'list channels\', or \'quit\': "
  user_input = gets.chomp.downcase
  case user_input
  when "list users"
    
    
    puts "Please select one of the following: \'list user\', \'list channels\', or \'quit\': "
    user_input = gets.chomp.downcase
  when "list channels"
    
    
    puts "Please select one of the following: \'list user\', \'list channels\', or \'quit\': "
    user_input = gets.chomp.downcase
  when "quit"
    break
  else
    
    puts "Invalid input. Please select \'list user\', \'list channels\', or \'quit\': "
    user_input = gets.chomp.downcase
  end
  
  
  puts "Thank you for using the Ada Slack CLI"
  # puts response['members'].first.keys
  
end

main if __FILE__ == $PROGRAM_NAME