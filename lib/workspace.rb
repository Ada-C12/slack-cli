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

    user_response["members"].each do |member|
    
      user_name = user_response["name"]
      user_slack_id = user_response["id"]
      user_real_name = user_response["real_name"]
      user_status_text = user_response["profile"]["status_text"]
      user_status_emoji = user_response["profile"]["status_emoji"]
  
      new_user = User.new(name: user_name, slack_id: user_slack_id, real_name: user_real_name, status_text: user_status_text, status_emoji: user_status_emoji)
    

      
      puts new_user

      @users << new_user

    end
    
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