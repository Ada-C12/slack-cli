

module SlackCLI
  class User < Recipient
    
    attr_reader :real_name
    def initialize(slack_id, name, real_name)
      super(slack_id, name)
      @real_name = real_name
    end
    
    
    def self.get
      url = "https://slack.com/api/users.list"
      query = { token: ENV["SLACK_API_TOKEN"] }
      response = HTTParty.get(url, query: query)
      
      return response["members"]
    end
    
    def self.all
      users = []
      
      self.get().each do |member|
        slack_id = member["id"]
        name = member["name"]
        real_name = member["real_name"]
        
        users << SlackCLI:: User.new(slack_id, name, real_name)
        
      end
      return users
      
    end
  end
end


