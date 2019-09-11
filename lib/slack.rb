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
  until choice == "quit" || choice == "3"
    puts "\nWhat would you like to do?"
    menu_options
    print "Action: " 
    choice = gets.chomp.downcase
    case choice
    when "1","list users"
      list_users
    when "2","list channels"
      list_channels
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
    ["3", "quit"]
  ]
  menu_table = Terminal::Table.new :headings => ["#", "Action"], :rows => numbered_options
  puts menu_table
end

def list_users
  # list users
end

def list_channels
  # list channels
end


main if __FILE__ == $PROGRAM_NAME
