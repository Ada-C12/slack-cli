require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load 

require_relative 'channel'
require_relative 'user'

module SlackCli
  class SlackSpace
    attr_reader :users, :channels, :selected

    def initialize(users:, channels:, selected:)
      @users = users
      @channels = channels
      @selected = selected 
    end 

    def start_program
      ap "Welcome to the Ada Slack CLI!"
      ap "What would you like ot do? Type one of the following: list channels, list users, or quit."
      user_input = gets.chomp.downcase

      while user_input != "quit"  
        case user_input 
        when "list channels"
          Channel.list
        when "list users"
          User.list
        else 
          # raise ArgumentError.new("Invalid input")
          puts "ARGUMENTERROR - FIX THIS"
        end 
        puts "What would you like to do? Type one of the following: list channels, list users, or quit."
        user_input = gets.chomp
      end 
      puts "Thank you for using the Sara & Monick Slack CLI"
    end 
  end 
end 

# main if __FILE__ == $PROGRAM_NAME
