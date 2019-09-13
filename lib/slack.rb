#!/usr/bin/env ruby
require_relative 'workspace'
require 'pry'


def main
  puts "Welcome to the Ada Slack CLI!"
  
  # Initializes a new workspace
  workspace = Workspace.new
  
  #Ternary statement to add 's' for more than 1 user 
  puts "There are #{workspace.users.length} user(s) in your workplace."
  
  puts "There are #{workspace.channels.length} channel(s) in your workspace."
  
  main_menu(workspace)
  
  puts "Thank you for using the Ada Slack CLI"
end

def main_menu(workspace)
  
  loop_options = ["1. List users", "2. List channels", "3. Quit"]
  
  puts "\nPlease select from one of the following options by choosing its corresponding number: "
  
  loop_options.each do |option|
    puts "\t #{option}"
  end
  
  input = gets.chomp.downcase
  
  until input == "quit" || input == "3" do
    case input
    when "1"
      puts
      puts workspace.all_user_names
      selected_user = make_a_selection(workspace)
      if selected_user == nil
        input = nil
      end
      
      selected_info = display_selected(workspace, selected_user)
      if selected_info == nil
        input = nil
      else puts selected_info  
      end
      
      input = nil
    when "2"
      puts workspace.all_channel_names
      selected_channel = make_a_selection(workspace)
      input = nil
    else
      print "\nPlease type the name of the user or channel you'd like to select: "
      loop_options.each do |option|
        puts "\t #{option}"          
      end
      eval = nil
      input = gets.chomp.downcase
    end
    
  end 
  
end

def make_a_selection(workspace)
  
  puts "If you would like to select a user, enter their corresponding number. Type \'BACK\' to go back."
  
  eval = nil
  until eval != nil
    second_input = gets.chomp.downcase  
    
    if second_input == "back"
      return nil
      
    elsif workspace.all_user_names.include?(second_input)
      puts "You selected the following user: #{second_input}."
      selected = nil
      binding.pry
      i = 0
      
      workspace.users.each do |possible_user|
        if possible_user[i].name == second_input
          puts "I evaluated a thing" 
          selected = possible_user
        end
        i += 1
      end
      
      puts "I got to the end"
      return_statement = [selected, "user"]
      return return_statement
      
    elsif workspace.all_channel_names.include?(second_input)
      puts "You selected the following channel: #{second_input}."
      selected = nil
      binding.pry
      workspace.channels.each do |possible_channel|
        if possible_channel.name == second_input
          selected = possible_channel
        end
      end
      
      
      return_statement = ["#{second_input}", "channel"]
      return return_statement
      
    else 
      eval = nil
      puts "You did not enter a valid user. Please try again: "
      second_input = gets.chomp.downcase 
    end
  end 
end

def display_selected(workspace, selection)
  puts "\n What would you like to know?
  \n \t * Details
  \n \t * Back"
  third_input = gets.chomp.downcase
  selection = selection[0]
  
  eval = nil 
  if third_input == "back"
    return nil 
  elsif third_input == "details"
    if selection[1] == "user"
      # binding.pry
      return workspace.selection.details
    elsif selection[1] == "channel"
      return workspace.channel.details
    end
  end
end 


main if __FILE__ == $PROGRAM_NAME