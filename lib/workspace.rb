require 'json'

module SlackCLI
  class Workspace
    
    attr_reader :users, :channels, :selected
    attr_accessor :bot_name, :bot_avatar
    
    def initialize()
      @users = SlackCLI::User.all
      @channels = SlackCLI::Channel.all
      @selected = nil
      
      settings = File.read("bot-settings.json")
      settings_hash = JSON.parse(settings)
      @bot_name = settings_hash["bot_name"]
      @bot_avatar = settings_hash["bot_avatar"]
    end
    
    def find_user(search_term)
      found_user = users.find do |user|
        user.name == search_term.downcase || user.slack_id == search_term.upcase
      end
      
      if found_user
        @selected = found_user
      else
        @selected = nil
      end
      
      return selected
    end
    
    def find_channel(search_term)
      found_channel = channels.find do |channel|
        channel.name == search_term.downcase || channel.slack_id == search_term.upcase
      end
      
      if found_channel
        @selected = found_channel
      else
        @selected = nil
      end
      
      return selected
    end
    
    def send_message(message_text)
      
      if selected.nil?
        return nil
      end
      
      bot_avatar_symbol = ":#{bot_avatar}:"
      
      response = HTTParty.post(
        "https://slack.com/api/chat.postMessage",
        body: {
          token: ENV["SLACK_API_TOKEN"],
          text: message_text,
          channel: selected.slack_id,
          as_user: false,
          username: bot_name,
          icon_emoji: bot_avatar_symbol
        },
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
      )
      
      return response
    end
    
    def save_settings
      settings_hash = {bot_name: bot_name, bot_avatar: bot_avatar}
      
      File.open("bot-settings.json", "w") do |f|
        f.write(settings_hash.to_json)  
      end
    end
    
    # Console methods
    def select_user
      print "Please enter the name or Slack ID of the user you want to select: "
      search_term = gets.chomp
      
      result = find_user(search_term)
      
      puts
      if result
        puts "The user #{result.name} was found and selected."
      else
        puts "No user was found."
      end
    end
    
    def select_channel
      print "Please enter the name or Slack ID of the channel you want to select: "
      search_term = gets.chomp
      
      result = find_channel(search_term)
      
      puts
      if result
        puts "The channel #{result.name} was found and selected."
      else
        puts "No channel was found."
      end
    end
    
    def print_details()
      puts
      if selected.class == SlackCLI::User
        tp selected, "name", "real_name", "slack_id"
      elsif selected.class == SlackCLI::Channel
        tp selected, "name", {"topic" => {:width => 60}}, "member_count", "slack_id"
      else
        puts "There is no recipient selected."
      end
    end
    
    def get_workplace_stats()
      user_count = users.length
      channel_count = channels.length
      return "This workplace has #{user_count} users and #{channel_count} channels."
    end
    
  end
end
