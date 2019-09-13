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
    puts "What would you like to do? Your options are: List channels, List user"  
    case gets.chomp
      
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
      workspace.select_channel(input)
    when "select user"
      User.list
      print "What user would you like to select: "
      input = gets.chomp
      workspace.select_user(input)
    when "show details"
      workspace.show_details
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