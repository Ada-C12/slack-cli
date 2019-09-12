class Channel
  
  
  #If inheriting from parent class, do I need to include inherited keyword arguments? 
  
  def initialize(name:, slack_id:, topic:, member_count:)
    
    
    if topic.class != String
      raise ArgumentError.new, "Wrong format for topic!"
    end 
    @topic = topic
    
    if member_count.class != Integer 
      raise ArgumentError.new, "Wrong format for member count!"
    end 
    @member_count = member_count
  end 
  
end