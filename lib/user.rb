module Slack
  class User
    attr_reader :name, :real_name, :slack_id

    def initialize(name:, real_name:, slack_id:)
      @name = name
      @real_name = real_name
      @slack_id = slack_id
    end

    def get_api
    end

    def list
      # response = self.get_api
    end


  end
end
