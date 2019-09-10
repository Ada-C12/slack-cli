#!/usr/bin/env ruby
require "httparty"
require "dotenv"
require "awesome_print"
require "table_print"

def main
  puts "Welcome to the Ada Slack CLI!"

  puts "Please select an option:
  -list users
  -list channels
  -quit"

  input = gets.chomp.downcase

  case input
  when "list users"
  when "list channels"
    Slack::Channel.list
  when "quit"
    break
  end
  # TODO project

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
