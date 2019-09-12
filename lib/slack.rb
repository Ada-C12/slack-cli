#!/usr/bin/env ruby
require 'awesome_print'
require 'httparty'
require 'dotenv'
Dotenv.load

require_relative 'lib_helper.rb'
require_relative 'recipient.rb'
require_relative 'user.rb'
require_relative 'channel.rb'
require_relative 'slackapierror.rb'
require_relative 'workspace.rb'





def main
  puts "\nWelcome to the Ada Slack CLI!\n\n"
  ws1 = Workspace.new
  entity = nil
  
  choices_hash = ws1.show_menu
  main_menu = ws1.main_menu(headings: ["", "MAIN MENU"], rows_as_hash: choices_hash)
  puts main_menu
  
  quit_program = false
  while quit_program == false 
    print "Please select from main menu: "
    choice = gets.chomp()
    
    result = ws1.menu_action(choice)
    if result
      if (result.class == User) || (result.class == Channel)
        ws1.entity = result
      end
    end
    
  end
  


  puts "OUT OF THE LOOP"
  
  
  
  
  
  # if selected: list_users
  # show list
  # show details
  
  # same for channels
  
  
  # quit
  
  
  # invalid?  show menu again
  
  
  puts "\nThank you for using the Ada Slack CLI\n\n"
end

main if __FILE__ == $PROGRAM_NAME