class User < Recipient
    attr_reader :slack_id, :name, :real_name

    def initialize(slack_id, name, real_name)
        super(slack_id, name) 
        @real_name = real_name
        @users_list = []
    end

    def self.list
        @users_list << self.User
        return @users_list
    end







end