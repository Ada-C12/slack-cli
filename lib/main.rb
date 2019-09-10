require 'dotenv'
require 'httparty'
require 'awesome_print'

require_relative 'recipient'
require_relative 'user'
require_relative 'workspace'
require_relative 'channel'

def main
  
  workspace = Slack::Workspace.new
  
  menu_choices = ["1", "list users", "2", "list channels", "3", "select user", "4", "select channel", "5", "details", "6", "quit"]
  should_continue = true
  
  while should_continue
    puts "Welcome to Slack! Please choose one of the following? \n1. list users \n2. list channels \n3. select user\n4. select channel\n5. details\n6. quit"
    input = gets.chomp.downcase
    
    if menu_choices.include? input
      case input
      when "1", "list users"
        workspace.list_users
      when "2", "list channels"
        workspace.list_channels
      when "3", "select user"
        puts "Please enter the name or slack ID of the user you want to select:"
        
        requested_user = gets.chomp
        found_user = workspace.select_user(requested_user)
        
        if found_user.class != Slack::User
          puts "User was not found."
        else 
          puts "User was selected."
        end
        
      when "4", "select channel"
        puts "Please enter the name or slack ID of the channel you want to select:"
        
        requested_channel = gets.chomp
        found_channel = workspace.select_channel(requested_channel)
        
        if found_channel.class != Slack::Channel
          puts "Channel was not found."
        else 
          puts "Channel was selected."
          puts workspace.selected
        end
      when "5", "details"
        if workspace.selected == nil
          puts "No user or channel selected."
        else
          puts workspace.selected.details
        end
      when "6", "quit"
        puts "Goodbye!"
        should_continue = false
      end
    else
    end
    
  end
  
  #ap workspace.users
  
end



main if __FILE__ == $PROGRAM_NAME