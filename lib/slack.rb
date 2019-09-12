 #lib/slack.rb
 require "httparty"
 require "awesome_print"
 require "colorize"
 require "table_print"
 
 require_relative "workspace"
 
 def main
  puts "Welcome to the Ada Slack CLI!".colorize(:color => :orange, :mode => :bold)
  @workspace = Slack::Workspace.new()
  
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
  when "list users"
    tp @workspace.users, "name", "id", "real_name"
    main
  when "list channels"
    tp @workspace.channels, "name", "id", "topic", "member_count"
    main
  when "select user"
    puts "Please enter username or Slack ID"
    user_selection = gets.chomp.downcase
    puts @workspace.select_user(user_selection)
    main
  when "select channel"
    puts "Please enter channel name or Slack ID"
    channel_selection = gets.chomp.downcase
    puts @workspace.select_channel(channel_selection)
    main
  when "details"
    puts @workspace.show_details
    main
  when "quit"
    exit
  else
    main
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME