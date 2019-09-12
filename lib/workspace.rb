require "dotenv"
require "httparty"
require "uri"
Dotenv.load

require_relative "recipient"
require_relative "channel"
require_relative "user"

class Workspace
  TOKEN = ENV["SLACK_TOKEN"]
  
  attr_accessor :users, :channels, :current_recipient #added these in order to access/update them; added current_recipient to hold the currently selected user or channel
  
  def initialize
    @channel_url = "https://slack.com/api/conversations.list"
    @user_url = "https://slack.com/api/users.list"
    @message_url = "https://slack.com/api/chat.postMessage"
    @channel_member_url = "https://slack.com/api/conversations.members"
    @users = get_users
    @channels = get_channels
    @current_recipient = nil
  end
  
  def get_users
    User.load_all(@user_url, TOKEN)
  end
  
  def get_channels
    Channel.load_all(@channel_url, TOKEN)
  end
  
  def find_by_id_or_name(recipient_type, search_arg)
    # verifies that the Recipient is either a User or a Channel
    # might want to move this validation into the slack.rb file
    if recipient_type != @users && recipient_type != @channels
      raise ArgumentError, "Recipient must be either a user or a channel."
    end
    
    # finds the recipient using the search_arg
    # search_arg could be a name or an id, either way works!
    recipient = recipient_type.find do |recipient|
      recipient.id == search_arg || recipient.name == search_arg
    end
    
    # raises arg error if the recipient isn't found by either name or id
    if recipient == nil
      raise ArgumentError, "Recipient not found."
    else
      @current_recipient = recipient
    end
  end
  
  # 'load_details' is a method in Recipient
  def list_details_on_current_recipient
    if @current_recipient == nil
      raise ArgumentError, "No recipient is currently selected."
    end
    @current_recipient.load_details
    ap @current_recipient
  end
  
  def send_message(message, cats)
    id = @current_recipient.id
  # this whole method probably needs gentle refactoring
    # this one prints cats with the text!
    if cats == "yes"
      cat_block = '[{"type": "image", "alt_text": "cat", "image_url": "https://cataas.com/cat/says/' + URI.encode(message) + '"}]'
      new_message = HTTParty.post(@message_url, 
        headers: { "Content-Type" => "application/x-www-form-urlencoded" }, 
        body: { 
          "token" => TOKEN,
          "channel" => id, 
          "text" => message,
          "blocks" => cat_block
        }
      )
    # this one prints regular text!
    else
      new_message = HTTParty.post(@message_url, 
        headers: { "Content-Type" => "application/x-www-form-urlencoded" }, 
        body: { 
          "token" => TOKEN,
          "channel" => id, 
          "text" => message
        }
      )
    end
    
    new_message
  end
  
  #  maaaaaaaaaybe we don't need these methods? we'll see!!
  # def select_user(id)
  #   User.set_as_recipient(id)
  # end
  # def select_channel(id)
  #   Channel.set_as_recipient(id)
  # end
  
  def list_users
    user_list = HTTParty.get(@user_url, query: { token: TOKEN })
    user_list["members"].map do |user|
      "ID: #{id = user["id"]}
      Username: #{username = user["name"]}
      Name: #{real_name = user["real_name"]}"
    end
  end
  
  def list_channels
    channel_list = HTTParty.get(@channel_url, query: { token: TOKEN })
    channel_list["channels"].map do |channel|
      "ID: #{id = channel["id"]} 
      Name: #{name = channel["name"]} 
      Topic: #{topic = channel["topic"]["value"]} 
      Member Count: #{member_count = channel["num_members"]}"
    end
  end
end
