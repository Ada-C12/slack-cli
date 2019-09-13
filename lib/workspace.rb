module SlackCLI
  class Workspace
    attr_reader :users, :channels
    attr_accessor :bot_name, :bot_avatar, :selected
    
    def initialize()
      @users = SlackCLI::User.all
      @channels = SlackCLI::Channel.all
      @selected = nil
      
      settings = File.read("bot-settings.json")
      settings_hash = JSON.parse(settings)
      @bot_name = settings_hash["bot_name"]
      @bot_avatar = settings_hash["bot_avatar"]
    end
    
    def get_workplace_stats()
      user_count = users.length
      channel_count = channels.length
      return "This workplace has #{user_count} users and #{channel_count} channels."
    end
    
    def find_user(search_term)
      found = users.find do |user|
        user.name == search_term.downcase || user.slack_id == search_term.upcase
      end
      
      return found
    end
    
    def find_channel(search_term)
      found = channels.find do |channel|
        channel.name == search_term.downcase || channel.slack_id == search_term.upcase
      end
      
      return found
    end
    
    def select_user(search_term)
      @selected = find_user(search_term)
      return selected
    end
    
    def select_channel(search_term)
      @selected = find_channel(search_term)
      return selected
    end
    
    def send_message(message_text)
      if selected.nil?
        return nil
      end
      
      bot_avatar_symbol = ":#{bot_avatar}:"
      
      response = HTTParty.post(
      "https://slack.com/api/chat.postMessage",
      body: { token: ENV["SLACK_API_TOKEN"],
      text: message_text,
      channel: selected.slack_id,
      as_user: false,
      username: bot_name,
      icon_emoji: bot_avatar_symbol },
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
      )
      
      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackAPIError, "Error when posting message, error: #{response.parsed_response["error"]}"
      end
      
      return response
    end
    
    def save_settings
      settings_hash = {bot_name: bot_name, bot_avatar: bot_avatar}
      
      File.open("bot-settings.json", "w") do |f|
        f.write(settings_hash.to_json)  
      end
    end
  end
end
