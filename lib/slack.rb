require "dotenv"
require "httparty"
require "table_print"

require_relative "recipient"
require_relative "user"
require_relative "channel"
require_relative "workspace"

Dotenv.load

def main
  workspace = Slack::Workspace.new 
  puts "\n"
  puts "Welcome to the Ada Slack CLI! This Slack workspace currently has #{workspace.users.count} users and #{workspace.channels.count} channels. Press enter to continue."
  
  user_input = gets.chomp
  
  until user_input == "quit"  
    print "Please choose an option: list users, list channels, select user, select channel, details, send message, or quit: "
    user_input = gets.chomp.downcase
    
    case user_input
    when "list users"
      tp workspace.users, "slack_id", "name", "real_name" 
      puts "\n"
      user_input = nil
      
    when "list channels"
      tp workspace.channels, "name", "topic", "member_count", "slack_id"
      puts "\n"
      user_input = nil
      
    when "select user"
      print "Please enter the user name or ID: "
      name_or_id = gets.chomp
      puts workspace.select(name_or_id)
      puts "\n"
      
    when "select channel"
      print "Please enter the channel name or ID: "
      name_or_id = gets.chomp
      puts workspace.select(name_or_id)
      puts "\n"
      
    when "details"
      if workspace.selected == nil
        puts "Please select a user or channel."
        user_input = nil
        puts "\n"
      else
        workspace.show_details
        user_input = nil
        puts "\n"
      end 
    when "send message"
      if workspace.selected == nil
        puts "Please select a user or channel."
        user_input = nil
        puts "\n"
      else
        print "Please enter your message: "
        message = gets.chomp
        slack_id = workspace.select(name_or_id)
        workspace.user_message(message, slack_id)
        puts "\n"
      end
    else
      puts "Sorry, I didn't understand your request. Please try again."
      puts "\n"
    end
  end 
  puts "Thank you for using the ADA Slack CLI!"
  puts "\n"
end

main if __FILE__ == $PROGRAM_NAME
