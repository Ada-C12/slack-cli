require 'httparty'

class Recipient
  attr_reader :slack_id, :name

  class SlackApiError < Exception; end

  def initialize(slack_id:, name:)
    @slack_id = slack_id
    @name = name
  end
 
  def self.list
    raise NotImplementedError, "template method"
  end

  def self.get(url, params)
    response = HTTParty.get(url, query: params)
    raise SlackApiError unless response['ok']

    return response.parsed_response
  end

  def details
    raise NotImplementedError, "template method"
  end
end
