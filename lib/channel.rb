class Channel


  #If inheriting from parent class, do I need to include inherited keyword arguments? 
  
  def initialize(name:, slack_id:, topic:, member_count:)
    @name = name 
    @slack_id = slack_id
    @topic = topic
    @member_count = member_count
  end 

end