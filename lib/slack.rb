require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load 

require_relative './channel'
require_relative 'user'

def start_program
  ap "Welcome to the Ada Slack CLI!"
  ap "What would you like ot do? Type one of the following: list channels, list users, or quit."
  user_input = gets.chomp.downcase
  while user_input != "quit"  
    case user_input 
    when "list channels"
      SlackCli::Channel.list
    when "list users"
      SlackCli::User.list 
    when "select user"
      ap "Type a username or Slack ID (case sensitivity matters)"
      search_user = gets.chomp
      selected = SlackCli::User.list.find do |i|
        i[:user_name]== search_user || i[:id] == search_user
      end
      if selected == nil 
        ap "Us or iner not foundvalid username or id"
      else 
        ap selected
      end 
    else 
      ap "Not a valid command"
    end 
    ap "What would you like to do? Type one of the following: list channels, list users, or quit."
    user_input = gets.chomp
  end 
  return "Thank you for using the Sara & Monick Slack CLI"
end 
start_program
