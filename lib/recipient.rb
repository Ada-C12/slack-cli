module SlackCLI
  
  class Recipient
    attr_reader :slack_id, :name
    def initialize(slack_id, name)
      @slack_id = slack_id
      @name = name
    end
    
    def self.get(url, params)
      raise NotImplementedError
    end
    
    def details
      raise NotImplementedError
    end
    
    def self.list
      raise NotImplementedError
    end
  end
  
end

