require_relative 'Recepient'

module Slack
  class Workspace 
    attr_reader :users, :channels
    def initialize
      @users = []
      @channels = []
    end
  end
end 

def main
  puts "Welcome to the Ada Slack CLI!"
  
  puts "Would you like to view: List Users, List Channels, or Quit?" # add number options?
  user_input = gets.chomp.split.map(&:capitalize).join(' ')

  while user_input != "List Users" && user_input != "List Channels" && user_input != "Quit"
    puts "\nIncorrect input!! Please select:  List Users, List Channels, or Quit"
    user_input = gets.chomp.split.map(&:capitalize).join(' ')
  end
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME