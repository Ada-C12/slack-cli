#!/usr/bin/env ruby
require_relative 'workspace'

def main
  workspace = Workspace.new
  
  
  puts "Welcome to the Ada Slack CLI!"
  puts "The number of channels is #{workspace.channels.length}."
  puts "The number of users is #{workspace.users.length}"
  
  puts "Do you want to list users, list channels, or quit?"
  search = gets.chomp.downcase
  until search == "quit"
    
    case search 
    when "quit"
      exit
    when "list users", "users"
      workspace.users.each do |user|
        puts
        puts "Username: #{user.name}" 
        puts "Real Name: #{user.real_name}"
        puts "Slack ID: #{user.slack_id}"
      end 
      puts
      puts "Do you want to list users, list channels, or quit?"
      search = gets.chomp.downcase
    when "list channels", "channels"
      workspace.channels.each do |channel|
        puts
        puts "Channel name: #{channel.name}"
        puts "Topic: #{channel.topic}"
        puts "Member count: #{channel.member_count}"
        puts "Slack ID: #{channel.slack_id}"
      end 
      puts
      puts "Do you want to list users, list channels, or quit?"
      search = gets.chomp.downcase
    end
  end
  
  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME




# url = "https://slack.com/api/channels.list"
# key = ENV["SLACK_TOKEN"]

# query = {
#   token: key
# }

# response = HTTParty.get(url, query: query)

# if response["error"]
#   raise StandardError.new "#{response.code}: #{response.message} -- #{response["error"]}"
# end

# response["channels"].each_with_index do |channel, index|
#   puts "#{index + 1}. #{channel["name"]}"
# end
