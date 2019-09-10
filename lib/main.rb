require 'dotenv'
require 'httparty'
require 'awesome_print'

require_relative 'recipient'
require_relative 'user'
require_relative 'workspace'
require_relative 'channel'

def main
  
  workspace = Slack::Workspace.new
  
  menu_choices = ["1", "list users", "2", "list channels", "3", "quit"]
  should_continue = true
  
  while should_continue
    puts "Welcome to Slack! Please choose one of the following? \n1. list users \n2. list channels \n3. quit"
    input = gets.chomp.downcase
    
    if menu_choices.include? input
      case input
      when "1", "list users"
        workspace.list_users
      when "2", "list channels"
        workspace.list_channels
      when "3", "quit"
        puts "Goodbye!"
        should_continue = false
      end
    else
    end
    
  end
  
  #ap workspace.users
  
end



main if __FILE__ == $PROGRAM_NAME