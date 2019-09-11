module Slack
  class User
    attr_reader :username, :real_name, :slack_id

    def initialize(username:, real_name:, slack_id:)
      @username = username
      @real_name = real_name
      @slack_id = slack_id
    end
  end
end
