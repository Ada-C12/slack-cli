class Recipient
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def send_message(message)
  end


  def self.get(url, params)
  end


  # ABSTRACT METHODS
  def details
  end


  def self.list
  #   BASE_URL = 
  #   TOKEN = ENV["SLACK_TOKEN"]

  #   query = {
  #   token: TOKEN
  #   }

  # response = HTTParty.get(BASE_URL, query: query)

  # response["slackbot"]["members".first]["id"]


  end
end


