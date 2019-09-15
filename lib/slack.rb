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
  eval = nil
  until eval == "exit"
    case input
    when "1"
      puts
      puts "Here is a list of all users: "
      all_users_details = []
      workspace.users.each do |user|
        all_users_details << user.details 
      end 
      puts all_users_details 
      selected_user = make_a_selection(workspace)
      if selected_user == nil
        eval = nil
        break
      else
        selected_info = display_selected(workspace, selected_user)
        if selected_info == nil
          break
        else puts selected_info  
        end
        input = nil
      end
    when "2"
      puts 
      puts "Here is a list of all channels: "
      all_channel_details = []
      workspace.channels.each do |channel|
        all_channel_details << channel.details
      end
      puts all_channel_details
      selected_channel = make_a_selection(workspace)
      if selected_channel == nil
        eval = nil
        break
      else
        selected_info = display_selected(workspace, selected_channel)
        if selected_info == nil
          break
        else puts selected_info
        end
        input = nil
      end
    when "3"
      eval = "exit"
    when "quit"
      eval = "exit"
    else
      puts "\nPlease select from one of the following options by choosing its corresponding number: "
      loop_options.each do |option|
        puts "\t #{option}"  
      end
      eval = nil
      input = gets.chomp.downcase
    end
    
  end 
  
end

def make_a_selection(workspace)
  print "\n You will be able to see details or send a message soon! Please select a user or channel by entering their corresponding name or Slack ID. If you'd like to exit, you may type \'QUIT\' to  quit the program.: "
  second_input = gets.chomp.downcase  
  
  if second_input == "quit" 
    return nil
  end
  
  selected = nil
  
  if workspace.all_user_names.include?(second_input) || workspace.all_user_slack_ids.include?(second_input)
    puts "You selected the following user: #{second_input}.\n "
    workspace.users.each do |possible_user|
      if possible_user.name == second_input || possible_user.slack_id == second_input
        selected = possible_user
      end
    end
    return_statement = [selected, "user"]
    return return_statement
    
  elsif workspace.all_channel_names.include?(second_input) || workspace.all_channel_slack_ids.include?(second_input)
    puts "You selected the following channel: #{second_input}. \n"
    workspace.channels.each do |possible_channel|
      if possible_channel.name == second_input || possible_channel.slack_id == second_input
        selected = possible_channel
      end
    end
    return_statement = [selected, "channel"]
    return return_statement
  else 
    puts "You did not enter a valid user. We're going to quit."
    return nil
  end
end 

def display_selected(workspace, selection) 
  puts "\n What would you like to know?
  \t * Details
  \t * Send message
  \t * Quit"
  
  third_input = gets.chomp.downcase
  if third_input == "quit"
    return nil
  end
  
  selection_text = selection[0]
  
  if third_input == "details"
    if selection[1] == "user"
      return selection_text.details
    elsif selection[1] == "channel"
      return selection_text.details
    end
  elsif third_input == "send message" 
    success_of_messaging = sending_message(workspace, selection)
    if success_of_messaging == true
      puts "You successfully sent your message. Great"
    else
      puts "Your message did not send. Sorry."
    end
  end
end 

def sending_message(workspace, selection)
  puts "What message do you want to send to #{selection[0].name}? \n Type it here: "
  message = gets.chomp
  
  success_of_sending = workspace.api_message_send(message, selection[0])
  return success_of_sending
  
end


main if __FILE__ == $PROGRAM_NAME