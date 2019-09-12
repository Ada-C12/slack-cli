require 'dotenv'
Dotenv.load
require_relative 'lib/user'
#this file equivilent must be in the main with .env

def main
  #@channel = Slack::Channel.new("CMUR2JTNX", "random", {"value"=>"", "creator"=>"", "last_set"=>0}, 7)
  @user_sam = Slack::User.new("UMTG0S5D0", "samantha.collares", "Samantha Collares")
  @user_list = @user_sam.list
  
  #binding.pry
  #binding.pry
  #@workspace = Slack::Workspace.new
  
  puts "Welcome to the Ada Slack CLI!"
  puts "Here are your options: "
  user_action_options = ["list users", "list channels", "select user", "select channel", "show details", "send message"]
  
  i = 1
  user_action_options.each do |option|
    puts "#{i}. #{option}"
    i += 1
  end
  
  puts "What would you like to do? > "
  user_choice = gets.chomp
  
  if user_choice == "1"
    #binding.pry
    puts @user_list
    #binding.pry
    puts "\nPlease select a user:"
    user_choice = gets.chomp
    #make find part user validation helper method?
    selected_user_object_id = @user_list.find { |user| user.value?(user_choice) }
    puts selected_user_object_id["slack_id"]
  end
end

puts "Thank you for using the Ada Slack CLI"

main

main if __FILE__ == $MARIYA_SLACK_TRYOUT