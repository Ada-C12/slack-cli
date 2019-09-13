require_relative 'recipient'
# require_relative 'slack'
require_relative 'user'
require_relative 'channel'
Dotenv.load

module SlackCLI
  class Workspace
    attr_reader :users, :channels, :selected
    
    def initialize
      @users = SlackCLI::User.list
      @channels = SlackCLI::Channel.list
      @selected = nil
    end
    
    def select_channel(name: nil, slack_id: nil)
      @selected = nil
      @channels.each do |channel|
        if channel.name == name || channel.slack_id == slack_id
          @selected = channel
        end
      end
      if @selected.nil? 
        raise SlackApiError.new("Channel not found")
      end
    end
    
    def select_user(user_name: nil, slack_id: nil)
      @selected = nil
      @users.each do |user|
        if user.user_name == user_name || user.slack_id == slack_id
          @selected = user
        end
      end
      if @selected.nil?
        raise SlackApiError.new("User not found")
      end
    end
    
    def show_details
      tp @selected
    end
    
    
    def send_message(message)
      uri = 'https://slack.com/api/'
      send_message = HTTParty.post("#{uri}/chat.postMessage", body: {
        token: ENV['SLACK_TOKEN'],
        text: message,
        channel: @selected.slack_id }, 
        headers: {'Content-Type' => 'application/x-www-form-urlencoded'})
        
        unless send_message["ok"]
          raise SlackApiError.new("Message Unable to Send")
        end
        return send_message
      end
    end
    
  end
  