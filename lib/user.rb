require_relative "../lib/recipient"
require "httparty"
require 'pry'

module Slack
  class User < Recipient
    attr_reader :real_name
    
    def initialize(slack_id, name, real_name)
      super(slack_id, name)
      
      @real_name = real_name
    end
    
  end
end 

# private

# def details
# end

# def self.list
# end 

#user = Slack::User.new("spengler")

