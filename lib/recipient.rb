module SlackBot
  class Recipient 
    attr_reader :slack_id, :name
    
    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
      
      if @slack_id.class != String || @slack_id.length != 9
        raise ArgumentError.new("Failure: slack_id must be a 9 character string")
      end 
      
    end
    
    def details
    end
    
    def self.list
    end
    
    def self.get(url, parameters)
    end
    
    def sent_message(message)
    end
    
  end
end
