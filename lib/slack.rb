#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'workspace'
require 'table_print'

Dotenv.load

def main
  
  puts "Welcome to the Ada Slack CLI!"
  
  workspace = Workspace.new
  puts "There are #{workspace.channels.length} channels"
  puts "There are #{workspace.users.length} users"
  
  while true
    options = ["list channels", "list users", "select channel", "select user", "show details", "send message", "quit"]
    puts "\nWhat would you like to do? Your options are: \n   list channels\n   list users\n   select channel\n   select user\n   show details\n   send message\n   quit"
    
    
    selection = gets.chomp
    until options.include?(selection.downcase) 
      puts "I'm sorry, please choose an option or quit"
      selection = gets.chomp
    end
    
    case selection
      
    when "quit"
      break
    when "list channels"
      Channel.list
    when "list users" 
      User.list
    when "select channel"
      Channel.list
      print "What channel would you like to select: "
      input = gets.chomp
      puts workspace.select_channel(input)
    when "select user"
      User.list
      print "What user would you like to select: "
      input = gets.chomp
      puts workspace.select_user(input)
    when "show details"
      puts workspace.show_details
    when 'send message'
      if workspace.send_message == false
        puts "your message did not send"
      else
        puts "Your message was successfully sent"
      end
    end
  end
  
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME