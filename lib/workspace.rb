require 'httparty'
require_relative 'user'
require_relative 'channel'
require 'dotenv'
Dotenv.load

class Workspace
 
 attr_reader :users, :channels
 
 def initialize
  @users = []
  @channels = []
  
  #method call to initiate calling API to populate users and channels to display the initial # of them
  
  # api_call_list_channels 
  # api_call_list_users 
 end
 
 def api_call_list_users
  #This method takes in the entire listuser api
  url = "https://slack.com/api/users.list"
  api_key = ENV['SLACK_TOKEN']
  
  query_parameters = {"token" => api_key}
  
  user_response = HTTParty.get(url, query: query_parameters)
  
  return user_response["ok"] == true 
  
 end 
 
 #  def api_call_listchannels(channel)
 #   #This method takes in the entire listchannel api 
 #   # url = "whatever_whatever"
 
 #   # parameters
 
 #   #have our method call
 #   #using response, pass it to make channels
 
 #   # make channels
 #   return channel_response
 #  end
 
 
 #  def make_users(user_response)
 #   # response["members"].each |user|
 #   # name = user["name"]
 
 
 
 #calling users instance variable 
 
 # make instances of users using the data from api_call
 
 # store instances of users using the data from api_call
 
 #  end
 
 def make_channels(channel_response)
  
  
  #parse data here into objects
  
  # make instances of channels using the data from api_call
  
  #store instances of channels using the data from api_call
  
 end
end