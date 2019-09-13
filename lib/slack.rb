#!/usr/bin/env ruby
require_relative 'workspace'

def main
  workspace = Workspace.new
  # variable to format command line entry
  prompt = "> "
  
  
  puts "Welcome to the Ada Slack CLI!"
  puts "The number of channels is #{workspace.channels.length}."
  puts "The number of users is #{workspace.users.length}"
  
  puts "Do you want to list users, list channels, select user, select channel, show details for selected, send message to selected or quit?"
  print prompt
  search = gets.chomp.downcase
  until search == "quit"
    
    case search 
    when "quit"
      exit
      
    when "list users", "users"
      puts
      puts "Listing Users..."
      workspace.users.each do |user|
        puts
        puts "Username: #{user.name}" 
        puts "Real Name: #{user.real_name}"
        puts "Slack ID: #{user.slack_id}"
      end 
      puts
      puts "Do you want to list users, list channels, select user, select channel, show details for selected, send message to selected or quit?"
      print prompt
      search = gets.chomp.downcase
      
    when "list channels", "channels"
      puts
      puts "Listing Channels..."
      workspace.channels.each do |channel|
        puts
        puts "Channel name: #{channel.name}"
        puts "Topic: #{channel.topic}"
        puts "Member count: #{channel.member_count}"
        puts "Slack ID: #{channel.slack_id}"
      end 
      puts
      puts "Do you want to list users, list channels, select user, select channel, show details for selected, send message to selected or quit?"
      print prompt
      search = gets.chomp.downcase
      
    when "select channel", "channel"
      puts "Please enter a channel name or slack_id for the channel you would like to select:"
      print prompt
      input = gets.chomp
      
      if workspace.select_channel(input: input)
        workspace.select_channel(input: input)
        puts """
        #{input} is now selected
        """
      else
        puts """
        No channel has that name or ID
        """
      end
      
      puts "Do you want to list users, list channels, select user, select channel, show details for selected, send message to selected or quit?"
      print prompt
      search = gets.chomp.downcase
      
    when "select user", "user"
      puts "Please enter a username or slack_id for the user you would like to select:"
      print prompt
      input = gets.chomp
      
      if workspace.select_user(input: input)
        workspace.select_user(input: input)
        puts """
        #{input} is now selected
        """
      else
        puts """
        No user has that name or ID
        """
      end
      
      puts "Do you want to list users, list channels, select user, select channel, show details for selected, send message to selected or quit?"
      print prompt
      search = gets.chomp.downcase
      
    when "details"
      if workspace.show_details
        puts "Here are the details for #{workspace.selected.name}:"
        puts workspace.show_details
      else
        puts """
        No recipient is currently selected
        """
      end
      
      puts "Do you want to list users, list channels, select user, select channel, show details for selected, send message to selected or quit?"
      print prompt
      search = gets.chomp.downcase
      
    when "send message", "message"
      unless workspace.selected.nil?
        puts "What message would you like to send to #{workspace.selected.name}?"
        message = gets.chomp
        
        workspace.send_message(message, workspace.selected.slack_id)
        
        puts """
        Message posted!
        """
      else
        puts """
        No recipient selected!
        """
      end
      
      puts "Do you want to list users, list channels, select user, select channel, show details for selected, send message to selected or quit?"
      print prompt
      search = gets.chomp.downcase
    else
      puts """
      Invalid Command
      """
      puts "Do you want to list users, list channels, select user, select channel, show details for selected, send message to selected or quit?"
      print prompt
      search = gets.chomp.downcase
    end  
  end
  
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

