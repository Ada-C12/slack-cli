#lib/slack.rb
require "httparty"
require "awesome_print"
require "colorize"
require "table_print"
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
 option = gets.chomp.downcase
 while option != "quit"
   if option == "list users"
     puts @workspace.users
   elsif option == "list channels"
     return @workspace.channels
   elsif option == "select user"
     return @workspace.select_user(option)
   elsif option == "select channel"
     return @workspace.select_channel(option)
   elsif option == "details"
     return @workspace.show_details
   elsif main
   else
     option == "quit"
     puts "Good Bye"
     exit
   end
 end
 puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME

