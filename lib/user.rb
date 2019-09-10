# username, real name, and Slack ID.

class User < Recipient
  attr_reader :real_name

  def initialize(name, real_name, slack_id)
    super(name, slack_id)
    @real_name = real_name
  end 
end