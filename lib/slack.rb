#!/usr/bin/env ruby
require "httparty"
require "dotenv"
require "awesome_print"
require "table_print"
require_relative "channel"
require_relative "user"
require_relative "workspace"
require_relative "recipient"

def main
  puts "Welcome to the Ada Slack CLI!"

  workspace = Slack::Workspace.new

  input = ""
  until input == "quit"
    puts "Please select an option:
    -list users
    -list channels
    -select user
    -quit"
    input = gets.chomp.downcase

    case input
    when "list users"
      user_array = Slack::User.list
      tp user_array
    when "list channels"
      channel_array = Slack::Channel.list
      tp channel_array
    when "select user"
      puts "Enter a username or slack id: "
      identifier = gets.chomp
      begin
        workspace.select_user(identifier)
      rescue
        puts "We couldn't find this user!"
      end
    when "quit"
      exit
    end
  end
  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
