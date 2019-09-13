class Recipient
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def get(url, query)
    return HTTParty.get(url, query)
  end

  # ABSTRACT METHODS
  def details
    raise NotImplementedError, "Implement me in a child class!"
  end

  def self.list
    raise NotImplementedError, "Implement me in a child class!"
  end
end


