require 'dotenv'
require 'httparty'
require 'awesome_print'
Dotenv.load 

 
def main
  puts "Welcome to the Ada Slack CLI! What would you like to do?"
  puts "list channels, list users, or quit"

  user_input = gets.chomp 
  case user_input 
  when "list channels"
    list_channels
  when "list users"
    list_users
  when "quit" 
    puts "Thank you for using the Ada Slack CLI"
    exit 
  end 
end
# main

def list_channels
  method_url = "https://slack.com/api/channels.list"
  query_params = {
    token: ENV["SLACK_TOKEN"]
  }
  response = HTTParty.get(method_url, query: query_params)

  channels = response.parsed_response["channels"]
  i = 0 
  channels.each do |channel|
    channel_name = response.parsed_response["channels"][i]["name"]
    i += 1
    puts channel_name
  end 
end 
list_channels

def list_users
  method_url = "https://slack.com/api/users.list"
  query_params = {
    token: ENV["SLACK_TOKEN"]
  }
  response = HTTParty.get(method_url, query: query_params)

  users = response.parsed_response["members"]
  i = 0
  users.each do |user|
    user_name = response.parsed_response["members"][i]["name"]
    i += 1
    puts user_name
  end 

end 
# list_users


# main if __FILE__ == $PROGRAM_NAME