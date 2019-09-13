#!/usr/bin/env ruby
require_relative 'workspace'
require 'table_print'
require 'terminal-table'

def main
  puts "\nWelcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new
  channels_count = workspace.channels.length
  users_count = workspace.users.length
  puts "\n#{channels_count} channels and #{users_count} users loaded"
  
  choice = ""
  until choice == "3" || choice == "quit"
    puts "\nWhat would you like to do?"
    menu_options
    print "Action: " 
    #Make an "ask for input" helper method?
    choice = gets.chomp.downcase
    
    case choice
    when "1","list users"
      puts "\n"
      list_users(workspace)
    when "2","list channels"
      puts "\n"
      list_channels(workspace)
    when "5","details"
      if workspace.show_details == nil
        puts "\nNo user or channel selected."
      else
        puts "#{workspace.show_details}"
      end 
    # when "6","send message"
    # if workspace.selected != nil
    # else "No user or channel (recipient) selected"
    # should confirm channel/user selected?
    # should do something if no channel/user selected
      
    when "6","quit" #change to option 7
      break
    else 
      puts "That option does not exist"
    end
  end
  
  puts "Thank you for using the Ada Slack CLI"
end

def menu_options
  numbered_options = [
    ["1", "list users"], 
    ["2", "list channels"], 
    ["3", "select user"],
    ["4", "select channel"],
    ["5", "details"],
    #["6", "send message"],
    ["6","quit"] # change to option 7
  ]
  menu_table = Terminal::Table.new :headings => ["#", "Action"], :rows => numbered_options
  puts menu_table
end

def list_users(workspace)
  tp workspace.users, :slack_id, :name, :real_name
end

def list_channels(workspace)
  tp workspace.channels, :slack_id, :name, :topic, :member_count
end


main if __FILE__ == $PROGRAM_NAME
