module SlackCLI
  
  class Recipient
    attr_reader :slack_id, :name
    
    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end
    
    def details
      raise NotImplementedError
    end
    
    def self.get(url)
      base_url = "https://slack.com/api/"
      url = base_url + url
      query = { token: ENV["SLACK_API_TOKEN"] }
      response = HTTParty.get(url, query: query)
      return response
    end
    
    def self.all
      raise NotImplementedError
    end
  end
end
