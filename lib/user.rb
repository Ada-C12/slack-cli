require 'httparty'

class User < Recipient
    attr_reader :slack_id, :name, :real_name
    @@users_list = []

    def initialize(slack_id, name, real_name)
        super(slack_id, name) 
        @real_name = real_name
        @@users_list << self
    end

    def self.list
      return @@users_list
    end

end