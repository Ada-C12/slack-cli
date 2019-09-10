class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  # def self.get_information(url, query)
  #   response = HTTParty.get(url, query: query)
  #   return response
  # end

  def self.get_information(url, query)
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def self.get_list
    raise NotImplementedError, 'Implement me in a child class!'
  end
end