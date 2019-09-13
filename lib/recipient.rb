class Recipient
  attr_reader :slack_id, :name
  
  def initialize(slack_id: , name: )
    @slack_id = slack_id
    @name = name
  end
  
  def self.get(url, params)
    query = {
      token: params 
    }
  
    response = HTTParty.get(url, query: query)
    
    if response["error"]
      raise SlackApiError.new "#{response.code}: #{response.message} -- #{response["error"]}"
    end
    
    return response
  end
  
  def details
    raise NotImplementedError.new "Implement me in a child class!"
  end
  
  def self.list
    raise NotImplementedError.new "Implement me in a child class!"
  end
end
