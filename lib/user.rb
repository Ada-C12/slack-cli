module SlackCLI
  class User < Recipient
    
    attr_reader :real_name
    
    def initialize(slack_id:, name:, real_name:)
      super(slack_id, name)
      @real_name = real_name
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
