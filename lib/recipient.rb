require 'HTTParty'

module SlackCLI
  
  class Recipient
    
    attr_reader :slack_id, :name
    
    def initialize(slack_id:, name:)
      slack_id = is_valid?(slack_id)
      name = is_valid?(name)
      
      @slack_id = slack_id 
      @name = name
    end
    
    def is_valid?(value)
      if value.nil?
        raise ArgumentError
      end
      return value
    end
    
    def self.get
      url = 'https://slack.com/api/channels.list'
      query_params = {
      token: ENV['SLACK_TOKEN']}
      response = HTTParty.get(url, params: query_params)
      unless response.code == 200
        raise SearchError.new("Cannot find channels")
      end
      return response
    end
    
  end
end



# # goal - list users in a workspace
# # generally - list channels in a workspace
# url = 'https://slack.com/api/channels.list'
# query_params = 
# # TODO project
# query_params = {
# token: ENV['SLACK_TOKEN']
# }
# array_of_channels = []
# response = HTTParty.get(url, params: query_params)
# response["channels"].each do |response|
#   hash_of_ids = {}
#   id = response["id"]
#   members = response["members"].length
#   topic = response["topic"]["value"]
#   name = response["name"]
#   hash_of_ids["id"] = id
#   hash_of_ids["members"] = members
#   hash_of_ids["topic"] = topic
#   hash_of_ids["name"] = name
#   array_of_channels << hash_of_ids
# end
