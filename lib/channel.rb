require_relative 'recipient'

class Channel < Recipient
  
  attr_reader :topic, :member_count 
  
  def initialize(name:, slack_id:, topic:, member_count:)
    super(name: name, slack_id: slack_id)
    
    if topic.class != String
      raise ArgumentError.new, "Wrong format for topic!"
    end 
    @topic = topic
    
    if member_count.class != Integer 
      raise ArgumentError.new, "Wrong format for member count!"
    end 
    @member_count = member_count
  end
  
  def details
    return "\n
    Name: #{@name}
    Topic: #{@topic}
    Slack id: #{@slack_id}
    Member count: #{@member_count}"    
  end 
  
end