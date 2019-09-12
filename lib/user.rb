require_relative 'recipient'
Dotenv.load

module SlackCLI
  class User < Recipient
    attr_reader :id, :user_name, :real_name
    
    def initialize(id:, user_name:, real_name:)
      @id = id
      @user_name = user_name
      @real_name = real_name
    end 
    
    def self.list
      response = HTTParty.get("https://slack.com/api/users.list?token=#{ENV['SLACK_TOKEN']}")
      array_of_users = []
      response["members"].each do |member|
        info_hash = {
          id: member["id"],
          user_name: member["name"],
          real_name: member ["profile"]["real_name"]
        }
        array_of_users << SlackCLI::User.new(info_hash)
      end
      return array_of_users
    end
  end
end

