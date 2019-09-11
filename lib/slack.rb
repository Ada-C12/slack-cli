#!/usr/bin/env ruby
require 'dotenv'
require 'httparty'
require 'awesome_print'
require_relative 'workspace'

Dotenv.load



def main
  
  puts "Welcome to the Ada Slack CLI!"
  
  workspace = Workspace.new
  puts "There are #{workspace.channels.length} channels"
  puts "There are #{workspace.users.length} users"
  
  puts "What would you like to do? These are your option:  _____"
  input = gets.chomp
  until input == "quit" do
    
    if input == "list channels"
      workspace.channels.each do |channel|
        puts channel.name
      end
    elsif input == "list users"
      puts User.list
    end
    
    input = gets.chomp
  end
  
  
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME