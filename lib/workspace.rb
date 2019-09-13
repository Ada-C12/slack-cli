require 'httparty'
require 'awesome_print'
require 'pry'
require 'dotenv'
Dotenv.load

require_relative 'slack_api_error'
require_relative 'recipient'
require_relative 'channel'
require_relative 'user'

class Workspace
  attr_reader :users, :channels, :selected
  
  def initialize
    @users = User.list
    @channels = Channel.list 
    @selected = nil
  end
  
  def select_channel(input: nil)
    channel_names = @channels.map { |channel| channel.name }
    channel_ids = @channels.map { |channel| channel.slack_id }
    
    if channel_names.include?(input)
      @selected = @channels.find { |c| input == c.name }
    elsif channel_ids.include?(input)
      @selected = @channels.find { |c| input == c.slack_id }
    else
      return nil
    end
    return @selected
  end
  
  def select_user(input: nil)
    usernames = @users.map { |user| user.name }
    user_ids = @users.map { |user| user.slack_id }
    
    if usernames.include?(input)
      @selected = @users.find { |u| input == u.name }
    elsif user_ids.include?(input)
      @selected = @users.find { |u| input == u.slack_id }
    else
      return nil
    end
    return @selected
  end
  
  def show_details
    return @selected.details if @selected
  end
  
  def send_message(message, channel)
    response = HTTParty.post(
      "https://slack.com/api/chat.postMessage",
      body: {
        token: ENV["SLACK_TOKEN"],
        channel: channel,
        text: message
      },
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    )

    if response["error"]
      raise SlackApiError.new "#{response.code}: #{response.message} -- #{response["error"]}"
    end
  
    return response
  end
end
