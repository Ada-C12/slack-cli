#lib/slack.rb
require "httparty"
require "awesome_print"
require "colorize"
require "table_print"
require 'dotenv'
require_relative "workspace"
require_relative 'message'
Dotenv.load

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
      sleep(2)
    when "list channels", "2"
      tp @workspace.channels, "name", "id", "topic", "member_count"
      sleep(2)
    when "select user", "3"
      puts "Please enter username or Slack ID"
      user_selection = gets.chomp
      @workspace.select_user(user_selection)
    when "select channel", "4"
      puts "Please enter channel name or Slack ID"
      channel_selection = gets.chomp
      @workspace.select_channel(channel_selection)
    when "details", "5"
      puts @workspace.show_details
      sleep(2)
    when "send message", "6"
      recipient = @workspace.recipient
      if recipient.class == Slack::Channel
        print "Please enter the message: "
        message = gets.chomp
        name = recipient.name
        Slack.send_msg(message, name)
      elsif recipient.class == Slack::User
        print "Please enter the message: "
        message = gets.chomp
        id = recipient.id
        Slack.send_msg(message, id)
      else recipient == nil
        puts "No recipient selected"
        sleep(2)
      end
    when "quit", "7"
      exit
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME