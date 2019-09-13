#!/usr/bin/env ruby
require "httparty"
require "dotenv"
require "awesome_print"
require "table_print"
require_relative "channel"
require_relative "user"
require_relative "workspace"
require_relative "recipient"

# For specific SlackApiError messages (https://stackoverflow.com/questions/3382866/rubys-exception-error-classes)

def main
  puts "Welcome to the Ada Slack CLI!"

  workspace = Slack::Workspace.new

  input = ""
  until input == "quit"
    puts "\nPlease select an option:

    -list users
    -list channels
    -select user
    -select channel
    -show details
    -send message
    -quit\n"
    input = gets.chomp.downcase

    case input
    when "list users"
      user_array = Slack::User.list
      tp user_array
    when "list channels"
      channel_array = Slack::Channel.list
      tp channel_array
    when "select user"
      puts "\n[Enter a username or slack id]"
      identifier = gets.chomp
      begin
        workspace.select_user(identifier)
      rescue SlackApiError => e
        puts "\n#{e.message}"
      end
    when "select channel"
      puts "\n[Enter a name or slack id]"
      identifier = gets.chomp
      begin
        workspace.select_channel(identifier)
      rescue SlackApiError => e
        puts "\n#{e.message}"
      end
    when "show details"
      if workspace.show_details == nil
        puts "\n[No user or channel has been selected]"
      else
        puts "#{workspace.show_details}"
      end
    when "send message"
      if workspace.selected == nil
        puts "\n[No user or channel has been selected]"
      else
        puts "What do you want to send?"
        message = gets.chomp
        workspace.send_message(message)
      end
    when "quit"
      puts "[Thank you for using the Ada Slack CLI]"
      exit
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
