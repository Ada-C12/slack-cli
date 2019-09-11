class Recipient
  
  attr_reader :name, :slack_id
  
  def initialize (name:, slack_id:)
    
    if name.class != String
      raise ArgumentError.new "wrong format for initiating name"
    end
    @name = name
    
    if id.class != String
      raise ArgumentError.new "wrong format for initiating id"
    end
    @id = id
    
  end
  

  def details
    raise NotImplementedError.new "not implemented in recipient class"
  end

  def self.list
    raise NotImplementedError.new "not implemented in recipient class"
  end
end
