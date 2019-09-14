require_relative 'recipient'

class User < Recipient
  
  attr_reader :real_name, :status_text, :status_emoji 
  
  def initialize(name:, slack_id:, real_name:, status_text:, status_emoji:)
    super(name: name, slack_id: slack_id)

    if real_name.class != String
      raise ArgumentError.new, "Wrong format for real name initialization"
    else 
      @real_name = real_name
    end 
    
    
    if status_text.class != String 
      raise ArgumentError.new, "Wrong format for status initialization"
    else
      @status_text = status_text
    end 
    
    if status_emoji.class != String
      raise ArgumentError.new, "Wrong format for emoji input"
    elsif status_emoji.length == 0
      @status_emoji = status_emoji
    elsif
      status_emoji[0] != ":" || status_emoji[-1] != ":"
      raise ArgumentError.new, "Wrong format for emoji input"
    else
      @status_emoji = status_emoji
    end 
    
    
    
  end 
  
  def details
    return "
    Name: #{@name}
    Slack id: #{@slack_id}
    Status text: #{@status_text}
    Status emoji: #{@status_emoji}
    Real name: #{@real_name}
    "
  end 
  
end