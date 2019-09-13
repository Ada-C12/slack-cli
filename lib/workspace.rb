require_relative "user"
require_relative "channel"
require_relative "acceptor"

module Slack
  class SlackApiError < StandardError; end
  class Workspace
    USER_URL = "https://slack.com/api/users.list"
    CHANNEL_URL = "https://slack.com/api/channels.list" 
    POST_MSG_URL = "https://slack.com/api/chat.postMessage"
    
    attr_reader :users, :channels, :selected

    def initialize
      @users = []
      @channels = []
      @selected = nil
    end

    def get_api(url)
      query_parameters = {
        token: ENV['SLACK_TOKEN']
      }
      return HTTParty.get(url, query: query_parameters)
    end

    def user_list
      api_user_response = get_api(USER_URL)
      api_members = api_user_response["members"]
      api_members.each do |each_member|
        username = each_member["name"]
        real_name = each_member["real_name"]
        slack_id = each_member["id"]
        @users << Slack::User.new(username: username, real_name: real_name, slack_id: slack_id)
      end
    end

    def print_user_list
      user_counter = 0
      result = ''
      @users.each do |each_user|
        user_counter += 1
        result = result + "User #{user_counter} - username: #{each_user.username}, real name: #{each_user.real_name}, Slack ID: #{each_user.slack_id}\n"
      end
      return result
    end

    def channel_list
      api_channel_response = get_api(CHANNEL_URL)
      api_channels = api_channel_response["channels"]
      api_channels.each do |each_channel|
        channel_name = each_channel["name"]
        topic = each_channel["topic"]["value"]
        member_count = each_channel["num_members"]
        slack_id = each_channel["id"]
        @channels << Channel.new(channel_name: channel_name, topic: topic, member_count: member_count, slack_id: slack_id)
      end
    end

    def print_channel_list
      channel_counter = 0
      result = ''
      @channels.each do |each_channel|
        channel_counter += 1
        result = result + "Channel #{channel_counter} - channel name: #{each_channel.channel_name}, topic: #{each_channel.topic}, member count: #{each_channel.member_count}, Slack ID: #{each_channel.slack_id}\n"
      end
      return result
    end

    def search(data_source, query_term)
      @selected = nil
      if data_source == "user"
        @users.each do |current_user|
          if current_user.username == query_term || current_user.slack_id == query_term
            @selected = current_user
            break
          end
        end
        return @selected
      elsif data_source == "channel"
        @channels.each do |current_channel|
          if current_channel.channel_name == query_term || current_channel.slack_id == query_term
            @selected = current_channel
            break
          end
        end
        return @selected
      end
    end

    def show_details(selected_receiver)
      details = ""
      if selected_receiver.class == Slack::User
        details = details + "Username: #{@selected.username}, Real name: #{@selected.real_name}, Slack ID: #{@selected.slack_id}"
        return details
      elsif selected_receiver.class == Slack::Channel
        details = details + "Channel name: #{@selected.channel_name}, Topic: #{@selected.topic}, Member count: #{@selected.member_count}, Slack ID: #{@selected.slack_id}"
        return details
      end
    end

    def send_message(message, selected_receiver)
      response = HTTParty.post(
        POST_MSG_URL,
        body:  {
          token: ENV['SLACK_TOKEN'],
          text: message,
          channel: selected_receiver
        },
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
      )
      
      unless response.parsed_response["ok"]
        raise SlackApiError, "Error when posting #{message} to #{selected_receiver}, error: #{response.parsed_response["error"]}"
      end
      return response
    end
  end 
end 