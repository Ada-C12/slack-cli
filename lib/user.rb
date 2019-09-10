require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_text
  
  def initialize(slack_id:, name:, real_name:, status_text:)  
    super(slack_id: slack_id, name: name)
    @real_name = real_name
    @status_text = status_text
  end
end
