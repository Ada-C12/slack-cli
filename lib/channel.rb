
  class Channel < Recipient
    attr_reader :topic, :member_count
    
    def initialize
      super(slack_id, name)
      @topic = topic
      @member_count = member_count
    end
    
    def details
      
      
    end
    
    
    def self.list
      
      
    end
    
  end
