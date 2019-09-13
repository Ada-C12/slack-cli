class User
  
  attr_reader :name, :slack_id, :real_name, :status_text, :status_emoji 
  
  def initialize(name:, slack_id:, real_name:, status_text:, status_emoji:)
    @name = name
    @slack_id = slack_id
    
    if real_name.class != String
      raise ArgumentError.new "Wrong format for real name initialization"
    end 
    @real_name = real_name
    
    if status_text.class != String 
      raise ArgumentError.new "Wrong format for status initialization"
    end 
    @status_text = status_text
    
    if status_emoji.class != String
      raise ArgumentError.new "Wrong format for emoji input!"
    end 
    @status_emoji = status_emoji
    
    # @details = details
  end 
  
  def details
    return "Name: #{@name}
    Slack id: #{@slack_id}
    Status text: #{@status_text}
    Status emoji: #{@status_emoji}
    Real name: #{@real_name}"
    
  end 
  
  
end