class User

  attr_reader

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

    #Verify here that status emoji contains : at the beginning and end of the string 
    if status_emoji[0] != ":" || status_emoji[-1] != ":"
      raise ArgumentError.new "Wrong format for emoji initialization"
    end 
    @status_emoji = status_emoji
  end 
end