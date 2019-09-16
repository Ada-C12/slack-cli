# require 'httparty'
# require 'dotenv'
require_relative 'workspace'
# require_relative 'user'
Dotenv.load


# !/usr/bin/env ruby

def main
  workspace = Workspace.new  
  
  puts "Welcome to the Ada Slack CLI!"
  puts "Select one of the following options: \'list users\', \'list channels\', \'select user\', \'select channel\', \'details\', \'send message'\ or \'quit\': "
  user_input = gets.chomp.downcase
  until user_input == "quit"
    case user_input
    when "list users", "list user", "user", "users"
      workspace.users.each do |user|
        puts """
        Slack ID:     #{user.slack_id}
        Real name:    #{user.real_name}
        Username:     #{user.user_name}
        """
      end
      
    when "list channels", "list channel", "channels", "channel"
      workspace.channels.each do |channel|
        puts """
        Slack ID:     #{channel.slack_id}
        Name:         #{channel.name}
        Topic:        #{channel.topic}
        Member count: #{channel.member_count}
        """
      end
      
    when "select user", "user"
      puts "Enter username or ID"
      selection = gets.chomp.downcase
      if workspace.select_user(selection) == nil
        puts "Invalid input - username or ID does not exist"
      end
      
    when "select channel", "channel"
      puts "Enter channel name or ID"
      selection = gets.chomp.downcase
      if workspace.select_channel(selection) == nil
        puts "Invalid input. Channel name or ID does not exist"
      end
      
    when "send message", "message"
      if workspace.selected == nil
        puts "A recipient has not been selected."
      else
        puts "Enter the message you would like to send:"
        message = gets.chomp
        workspace.send_message(message, workspace.selected.slack_id)
        puts "You sent the following message:"
        puts message
      end
      
    when "details", "detail"
      if workspace.show_details == nil
        puts "No recipient (user/channel) has been selected"
      end
      puts """
      #{workspace.show_details.slack_id}
      #{workspace.show_details.detail}
      """
      
    end
    
    puts "Select one of the following options: \'list users\', \'list channels\', \'select user\', \'select channel\',  \'send message'\ \'details\' or \'quit\': "
    user_input = gets.chomp.downcase
  end
  
  
  puts "Thank you for using the Ada Slack CLI"
  # puts response['members'].first.keys
  
end




main if __FILE__ == $PROGRAM_NAME