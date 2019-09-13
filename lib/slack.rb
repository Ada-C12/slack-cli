#lib/slack.rb
require "httparty"
require "awesome_print"
require "colorize"
require "table_print"
require_relative "workspace"

def main
  @workspace = Slack::Workspace.new()
  while true
    puts "Welcome to the Ada Slack CLI!".colorize(:color => :orange, :mode => :bold)
    puts "\nPlease Choose from the following options:
    \n1. List Users
    \n2. List Channels
    \n3. Select User
    \n4. Select Channel
    \n5. Details
    \n6. Send Message
    \n7. Quit".colorize(:color => :purple, :mode => :bold)
 
    option = gets.chomp.downcase
    
    case option
    when "list users", "1"
      tp @workspace.users, "name", "id", "real_name"
      sleep(5)
    when "list channels", "2"
      tp @workspace.channels, "name", "id", "topic", "member_count"
      sleep(5)
    when "select user", "3"
      puts "Please enter username or Slack ID"
      user_selection = gets.chomp.downcase
      puts @workspace.select_user(user_selection)
    when "select channel", "4"
      puts "Please enter channel name or Slack ID"
      channel_selection = gets.chomp.downcase
      puts @workspace.select_channel(channel_selection)
    when "details", "5"
      puts @workspace.show_details
      sleep(5)
    when "send message", "6"
      
    when "quit", "7"
      exit
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME