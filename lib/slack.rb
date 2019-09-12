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


# THESE ARE THE 3 THINGS WE'RE ALLOWED TO DO ON THIS API
# chat:write:bot
# channels:read
# users:read

def main
  puts "\nWelcome to the Ada Slack CLI!\n\n"
  ws1 = Workspace.new
  ''
  # WS1.show menu => hash of choices
  
  
  choice_valid = false
  while choice_valid == false
    puts "MENU HERE: #{hash}"
    print "choice =  "
    choice = gets.chomp()
    
    choice = ws1.eval_choice(choice)
    if approved
      choice_valid = true
    end
  end
  
  
  
  
  
  # if selected: list_users
  # show list
  # show details
  
  # same for channels
  
  
  # quit
  
  
  # invalid?  show menu again
  
  
  puts "\nThank you for using the Ada Slack CLI\n\n"
end

main if __FILE__ == $PROGRAM_NAME