require_relative 'recipient'

class Channel < Recipient
  attr_reader :topic, :member_count
  
  def initialize(slack_id, name)
    super (slack_id, name)
    @topic = nil
    @member_count = nil
  end
  
  
  private
  def details
    
  end
  
  def self.list
    
  end
  
end