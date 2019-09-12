module SlackCLI
  class User < Recipient    
    attr_reader :real_name
    
    def initialize(slack_id:, name:, real_name:)
      super(slack_id, name)
      @real_name = real_name
    end
    
    def get_dm_channels
      url = "https://slack.com/api/im.list"
      query = { token: ENV["SLACK_API_TOKEN"]}
      response = HTTParty.get(url, query: query)
      
      puts response
      
      
      im_history_url = "https://slack.com/api/im.history"
      query = { token: ENV["SLACK_API_TOKEN"], channel: "DN69AJ9K2"}
      response2 = HTTParty.get(im_history_url, query: query)
      
      
      puts "\n"
      puts response2
      
      
      
      im_history_url2 = "https://slack.com/api/im.history"
      query = { token: ENV["SLACK_API_TOKEN"], channel: "DN85DC8MD"}
      response3 = HTTParty.get(im_history_url2, query: query)
      
      
      
      
      
      
      
      # im_history_url = "https://slack.com/api/search.messages"
      # query = { token: ENV["SLACK_API_TOKEN"], query: "slackbot"}
      # response3 = HTTParty.get(url, query: query)
      
      
      
      
      
      puts "\n"
      
      puts response3
      
    end
    
    
    
    
    # def get_message_history
    #   url = "https://slack.com/api/im.history"
    
    #   query = { token: ENV["SLACK_API_TOKEN"], channel: ""}
    #   response = HTTParty.get(url, query: query)
    
    #   puts response
    # end
    
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
