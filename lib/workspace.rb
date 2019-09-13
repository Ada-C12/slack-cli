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
    api_call_list_channels 
  end
  
  
  def all_user_names
    all_user_names = []
    
    users.each do |user|
      all_user_names << user.name 
    end 
    return all_user_names 
  end 
  
  def all_channel_names
    all_channel_names = []
    
    channels.each do |channel| 
      all_channel_names << channel.name
    end
    return all_channel_names
  end 
  
  def api_call_list_users
    #This method takes in the entire listuser api
    url = "https://slack.com/api/users.list"
    api_key = ENV['SLACK_TOKEN']
    
    query_parameters = {"token" => api_key}
    
    user_response = HTTParty.get(url, query: query_parameters)
    
    make_users(user_response)
    
    return user_response["ok"] == true 
  end
  
  def make_users(response)
    total_users = response["members"].length
    i = 0
    
    until i == total_users 
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
  
  def api_call_list_channels
    #This method takes in the entire listuser api
    url = "https://slack.com/api/conversations.list"
    api_key = ENV['SLACK_TOKEN']
    query_parameters = {"token" => api_key}
    channel_response = HTTParty.get(url, query: query_parameters)
    make_channels(channel_response)
    return channel_response["ok"] == true 
  end
  
  
  def make_channels(response)
    total_channels = response["channels"].length
    i = 0
    until i == total_channels
      channel_name = response["channels"][i]["name"]
      channel_slack_id = response["channels"][i]["id"]
      channel_topic = response["channels"][i]["topic"]["value"]
      channel_member_count = response["channels"][i]["num_members"]
      
      new_channel = Channel.new(name: channel_name, slack_id: channel_slack_id, topic: channel_topic, member_count: channel_member_count)
      
      @channels << new_channel
      
      i += 1
    end
  end
end