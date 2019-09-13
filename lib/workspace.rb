require "dotenv"
require "httparty"
require "uri"
Dotenv.load

require_relative "recipient"
require_relative "channel"
require_relative "user"

class Workspace
  TOKEN = ENV["SLACK_TOKEN"]

  attr_accessor :users, :channels, :current_recipient, :user_url, :channel_url, :message_url

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

  def valid_selection?(selection_type, selection)
    case selection_type
    when "channel"
      @channels.find { |channel| channel.id == selection || channel.name == selection } ? true : false
    when "user"
      @users.find { |user| user.id == selection || user.name == selection } ? true : false
    end
  end

  def find_by_id_or_name(recipient_type, search_arg)
    if recipient_type.downcase != "user" && recipient_type.downcase != "channel"
      raise ArgumentError, "Recipient must be either a user or a channel."
    end

    recipient_list = []
    if (recipient_type.downcase == "user")
      recipient_list = @users
    else
      recipient_list = @channels
    end

    recipient = recipient_list.find do |recipient|
      recipient.id == search_arg || recipient.name == search_arg
    end

    if recipient == nil
      raise ArgumentError, "Recipient not found."
    else
      @current_recipient = recipient
    end
  end

  def list_details_on_current_recipient
    if @current_recipient == nil
      raise ArgumentError, "No recipient is currently selected."
    else
      @current_recipient.load_details
    end
    return @current_recipient
  end

  def send_message(message, cats)
    id = @current_recipient.id
    if cats == "yes"
      cat_block = '[{"type": "image", "alt_text": "cat", "image_url": "https://cataas.com/cat/says/' + URI.encode(message) + '"}]'
      new_message = HTTParty.post(@message_url,
                                  headers: { "Content-Type" => "application/x-www-form-urlencoded" },
                                  body: {
                                    "token" => TOKEN,
                                    "channel" => id,
                                    "text" => message,
                                    "blocks" => cat_block,
                                  })
    else
      new_message = HTTParty.post(@message_url,
                                  headers: { "Content-Type" => "application/x-www-form-urlencoded" },
                                  body: {
                                    "token" => TOKEN,
                                    "channel" => id,
                                    "text" => message,
                                  })
    end
    new_message
  end

  def list_users
    user_list = HTTParty.get(@user_url, query: { token: TOKEN })
    user_list["members"].map do |user|
      "ID: #{user["id"]}
      Username: #{user["name"]}
      Name: #{user["real_name"]}"
    end
  end

  def list_channels
    channel_list = HTTParty.get(@channel_url, query: { token: TOKEN })
    channel_list["channels"].map do |channel|
      "ID: #{channel["id"]} 
      Name: #{channel["name"]} 
      Topic: #{channel["topic"]["value"]} 
      Member Count: #{channel["num_members"]}"
    end
  end
end
