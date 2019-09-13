require 'httparty'
require 'dotenv'
require 'table_print'
require_relative 'workspace'
# require_relative 'user'
Dotenv.load


# !/usr/bin/env ruby

def main
  workspace = Workspace.new  
  
  puts "Welcome to the Ada Slack CLI!"
  
  # TODO project
  puts "Please select one of the following: \'list users\', \'list channels\', or \'quit\': "
  user_input = gets.chomp.downcase
  
  case user_input
  when "list users"
    workspace.users.each do |user|
      puts """
      #{user.slack_id}
      #{user.real_name}
      #{user.user_name}
      """
    end
  when "list channels"
    puts Workspace.new.channels
  when "quit"
    exit
  end
  # when "list users"
  
  
  #   puts "Please select one of the following: \'list user\', \'list channels\', or \'quit\': "
  #   user_input = gets.chomp.downcase
  # case 
  
  #   Workspace.select_channel(user_input)
  
  
  # when "list channels"
  
  
  #   puts "Please select one of the following: \'list user\', \'list channels\', or \'quit\': "
  #   user_input = gets.chomp.downcase
  # when "quit"
  #   break
  # else
  
  # puts "Invalid input. Please select \'list user\', \'list channels\', or \'quit\': "
  # user_input = gets.chomp.downcase
  
  puts "Thank you for using the Ada Slack CLI"
  # puts response['members'].first.keys
  
end




main if __FILE__ == $PROGRAM_NAME