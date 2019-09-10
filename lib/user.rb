
  class User < Recipient
    attr_reader :real_name, :status_text, :status_emoji
    
    def initialize
      super(slack_id, name)
      @real_name = real_name
      @status_text = status_text
      @status_emoji = status_emoji
    end
    
    def details
      
      
    end
    
    
    def self.list
      
      
    end
    
  end
