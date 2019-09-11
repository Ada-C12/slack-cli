require_relative "workspace"
require_relative "user"
require_relative "channel"
require_relative "acceptor"
require 'httparty'
require "dotenv"
Dotenv.load

def main
  
  puts "Welcome to the Ada Slack CLI!"
  # TO-DO: Display total count of users and channels
  workspace = Slack::Workspace.new
  workspace.user_list
  puts "Darn Cute Puppers has #{workspace.users.count} users."

  prompt = "Please select from the following options: 
  List Users
  List Channels
  Quit"

  puts prompt
  
  while command = gets.chomp.downcase
    case command
    when "quit"
      exit
    when "list users"
      puts workspace.print_user_list
      break
    # when "list channels"
      # TO-DO: call print_list method for channel
      # break - to avoid asking for more input
    else
      puts "Error: Invalid selection. Returning to main menu...."
      puts prompt
    end
  end
  puts "Thank you for using the Ada Slack CLI"

end

main if __FILE__ == $PROGRAM_NAME

