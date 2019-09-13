require_relative 'lib_helper.rb'

class Recipient
  
  attr_reader :id, :name
  
  def initialize(id:, name:)
    @id = id
    @name = name
  end
  
  def send_msg(msg)
    # WAVE 3
  end
  
  def self.get(url, params)
    response = HTTParty.get(url, query: params)
    
    if response["ok"] == true
      return response
    else
      raise SlackAPIError, "API request failed!"
    end
  end
  
  def details
    raise NotImplementedError, "Do this either User or Channel"
  end
  
  def self.load_all
    raise NotImplementedError, "Do this either User or Channel"
  end
  
end