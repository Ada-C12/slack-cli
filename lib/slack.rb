#!/usr/bin/env ruby
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  
  # Initializes a new workspace
  workspace = Workspace.new
  
  #Ternary statement to add 's' for more than 1 user 
  puts "There are #{workspace.users.length} user(s) in your workplace."
  
  puts "There are #{workspace.channels.length} channel(s) in your workspace."
  
  loop_options = ["1. List users", "2. List channels", "3. Quit"]
  
  puts "\nPlease select from one of the following options by choosing its corresponding number: "
  loop_options.each do |option|
    puts "\t #{option}"
  end
  input = gets.chomp.downcase
  
  until input == "quit" || input == "3" do
    case input
    when "1"
      puts workspace.all_user_names
      # select user method



      input = nil
    when "2"
      puts workspace.all_channel_names
      input = nil
    else
      print "\nPlease select from one of the following options by choosing its corresponding number: "
      loop_options.each do |option|
        puts "\t #{option}"          
      end
      eval = nil
      input = gets.chomp.downcase
    end
  end
  puts "Thank you for using the Ada Slack CLI"
end


  # def select_a_user
  # puts "Would you like to select a user?"
  # until input== 3
  # input = gets.chomp
  # if y 
  #   puts "what user do you want to select"
  # selected = gets.chomp
  # (must be a user name)
  # if invalid do a thing
  #   if valid
  #   # selected_user_method
  #   if desired "go back"
  # end

  # def selected_user
  #   puts "What would you like to know? "
  #   # details
  #   # message
  #   if desired "go back"
  # end


main if __FILE__ == $PROGRAM_NAME