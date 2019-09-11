# username, real name, and Slack ID.

class User < Recipient
  attr_reader :real_name

  def initialize(name, real_name, slack_id)
    super(name, slack_id)
    @real_name = real_name
  end 

  def self.get(url, query)
    url = "https://slack.com/api/users.list"
    query = {token: ENV['SLACK_TOKEN']}

    response = HTTParty.get(url, query: query)
    return response
  end
end