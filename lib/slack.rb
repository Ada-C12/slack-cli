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
  puts "Please select one of the following: \'list users\', \'list channels\', or \'quit\': "
  user_input = gets.chomp.downcase
  until user_input == "quit"
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
      workspace.channels.each do |channel|
        puts """
        #{channel.slack_id}
        #{channel.name}
        #{channel.topic}
        #{channel.member_count}
        """
      end
      
    when "select user"
      puts "Please give me the username or ID"
      selection = gets.chomp.downcase
      if workspace.select_user(selection) != nil
        puts "Invalid input. Username or ID does not exist"
      end
      
    end
    
    puts "Please select one of the following: \'list users\', \'list channels\', or \'quit\': "
    user_input = gets.chomp.downcase
  end
  
  
  
  
  
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