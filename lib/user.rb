require_relative 'recipient'
require 'httparty'


module SlackCLI
  class User < Recipient
    attr_reader :real_name
    
    def initialize(slack_id:, name:, real_name:)
      super(slack_id: slack_id, name: name)
      @real_name = real_name
    end
    
    def self.list
      response = self.get("https://slack.com/api/users.list")
      
      users = response["members"].map do |member|
        slack_id = member["id"]
        name = member["name"]
        real_name = member["real_name"]
        
        SlackCLI::User.new(slack_id: slack_id, name: name, real_name: real_name)
      end
      
      return users
    end
    
    # def details
    # end
    
  end
end
