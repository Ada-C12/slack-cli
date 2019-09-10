# To get this to work properly, running it in ruby (ruby.set_up.rb) you must be in the general project folder NOT lib. Run it from the project folder. This is a specificity problem because the .env file doesn't live in Lib so ruby can't find it from here. 

# Run this in ruby as (ruby lib/set_up.rb)

require 'httparty'
require 'pry'

require 'dotenv'
Dotenv.load

def set_up_test
 
 url = "https://slack.com/api/conversations.list"
 
 query_params = {
  token: ENV["SLACK_TOKEN"]
 }
 
 response = HTTParty.get(url, query: query_params)
 
 return response
 
end

puts set_up_test