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

    puts "Welcome to the Ada Slack CLI! What would you like to do?"
    puts "list channels, list users, or quit"
  
    user_input = gets.chomp 
    case user_input 
    when "list channels"
      Channel.list
    when "list users"
      User.list
    when "quit" 
      puts "Thank you for using the Ada Slack CLI"
      exit 
    end 
  end 

end 


# main if __FILE__ == $PROGRAM_NAME
