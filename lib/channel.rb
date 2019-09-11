require_relative "../lib/recipient"
require "httparty"
require 'pry'

module Slack
  class Channel < Recipient
    attr_reader :topic, :member_count
    
    def initialize(slack_id, name, topic = nil, member_count)
      super(slack_id, name)
      
      @topic = topic
      @member_count = member_count
    end
    
    private
    
    # def details
    # end
    
    # def self.list
    # end 
    
  end 
end
