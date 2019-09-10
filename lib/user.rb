require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji
  
  def initialize(slack_id, name)
    
    super (slack_id, name)
    @real_name = nil
    @status_text = nil
    @status_emoji = nil
  end
  
  
  private
  def details
    
  end
  
  def self.list
    
  end
  
end