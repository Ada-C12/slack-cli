require 'httparty'
require_relative 'user'
require_relative 'channel'
require 'dotenv'
Dotenv.load

require 'pry'

class Workspace
  
  attr_reader :users, :channels
  
  def initialize
    @users = []
    @channels = []
    
    #method call to initiate calling API to populate users and channels to display the initial # of them
    
    api_call_list_users 
  end
  
  def api_call_list_users
    #This method takes in the entire listuser api
    url = "https://slack.com/api/users.list"
    api_key = ENV['SLACK_TOKEN']
    
    query_parameters = {"token" => api_key}
    
    user_response = HTTParty.get(url, query: query_parameters)
    
    puts user_response
    make_users(user_response)
    
    return user_response["ok"] == true 
  end
  
  def make_users(response)
    
    total_users = response["members"].length
    i = 0
    # binding.pry
    until i == total_users do
      user_name = response["members"][i]["name"]
      user_slack_id = response["members"][i]["id"]
      user_real_name = response["members"][i]["real_name"]
      user_status_text = response["members"][i]["profile"]["status_text"]
      user_status_emoji = response["members"][i]["profile"]["status_emoji"]
      
      new_user = User.new(name: user_name, slack_id: user_slack_id, real_name: user_real_name, status_text: user_status_text, status_emoji: user_status_emoji)
      
      @users << new_user
      
      i += 1
      
    end
    
  end
  
  
  
  def make_channels(channel_response)
    
    #parse data here into objects
    
    # make instances of channels using the data from api_call
    
    #store instances of channels using the data from api_call
    
  end
end