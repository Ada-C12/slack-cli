#lib/slack.rb
require "httparty"
require "awesome_print"
require "colorize"
require_relative "workspace"

def main
  puts "Welcome to the Ada Slack CLI!".colorize(:color => :blue, :mode => :bold)
  @workspace = Slack::Workspace.new() 
  
  puts "\nPlease Choose from the following options:
  \n1. List Users
  \n2. List Channels
  \n3. Select User
  \n4. Select Channel
  \n5. Details
  \n6. Send Message
  \n7. Quit".colorize(:color => :blue, :mode => :bold)
  
  option = gets.chomps.upcase
  
  until option == "QUIT"
    if option == "List Users"
      return @workspace.users
    elsif option == "List Channels"
      return @workspace.channels
    elsif option == "Select User"
      return @workspace.select_user(option)
    elsif option == "Select Channel"
      return @workspace.select_channel(option)
    elsif option == "Details"
      return @workspace.show_details
      
      main 
      puts "Good Bye"
      break 
    end
    
    
    puts "Thank you for using the Ada Slack CLI"
  end
  
  main if __FILE__ == $PROGRAM_NAME
  