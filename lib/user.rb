module SlackCLI
  class User < Recipient    
    attr_reader :real_name
    
    def initialize(slack_id:, name:, real_name:)
      super(slack_id, name)
      @real_name = real_name
    end
    
    def get_message_history
      im_url = "https://slack.com/api/im.list"
      im_query = { token: ENV["SLACK_API_TOKEN"]}
      im_response = HTTParty.get(im_url, query: im_query)
      
      unless im_response.code == 200 && im_response.parsed_response["ok"]
        raise SlackAPIError, "Error when getting im list, error: #{im_response.parsed_response["error"]}"
      end
      
      ims = im_response["ims"]
      
      direct_channel = ims.find do |im|
        im["user"] == slack_id
      end
      
      direct_channel_id = direct_channel["id"]
      
      url = "https://slack.com/api/conversations.history"
      query = { token: ENV["SLACK_API_TOKEN"] , channel: direct_channel_id}
      response = HTTParty.get(url, query: query)
      
      unless response.code == 200 && response.parsed_response["ok"]
        raise SlackAPIError, "Error when getting conversations history, error: #{response.parsed_response["error"]}"
      end
      
      return response  
    end
    
    def self.all
      users = []
      
      response = User.get("users.list")
      
      response["members"].each do |member|
        slack_id = member["id"]
        name = member["name"]
        real_name = member["real_name"]
        
        users << SlackCLI:: User.new(slack_id: slack_id, name: name, real_name: real_name)
      end
      return users
    end
  end
end
