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
      @channels.each do |channel|
        if channel.name == name || channel.slack_id == slack_id
          @selected = channel
        end
      end
    end
    
    def select_user(user_name: nil, slack_id: nil)
      @users.each do |user|
        if user.user_name == user_name || user.slack_id == slack_id
          @selected = user
        end
      end
    end
    
    def show_details
    end
    
    def send_message
    end
    
  end
end