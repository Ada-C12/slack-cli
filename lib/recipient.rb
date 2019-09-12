require 'HTTParty'
require 'dotenv'



module SlackCLI
  
  class Recipient
    def initialize
    end
    
    def self.list_channels
      raise NotImplementedError.new("Call this method in child class")
    end
    
    
    
    def self.get(url)
      # # url = 'https://slack.com/api/channels.list'
      # query_params = {
      # token: ENV['SLACK_TOKEN']}
      # response = HTTParty.get(url, params: query_params)
      # unless response.code == 200
      #   raise SearchError.new("Cannot find channels")
      # end
      # return response
    end
    
  end
end

