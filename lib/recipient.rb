require 'httparty'

class Recipient
  attr_reader :slack_id, :name
  
  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end
 
  def self.list
    []
  end

  def self.get(url, params)
    HTTParty.get(url, query: params).parsed_response
  end

  def details
    raise NotImplementedError, "template method"
  end
end
