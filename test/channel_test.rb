require_relative 'test_helper'
require_relative '../lib/channel'
require_relative '../lib/recipient'
require 'pry'
require 'httparty'
require  'dotenv'

Dotenv.load



describe "Channel class" do
  
  
  it "instantiate the Channel class" do
    slack_id:, name:, topic:, member_count:
    
    expect(Channel.new(slack_id: 123, name: "John", topic: "Smiths", member_count: 4)).must_be_instance_of Channel
    
  end
  
  it "assigns correct value to instance variables" do
    channels = Channel.new(slack_id: 123, name: "John", topic: "Smiths", member_count: 4)
    
    expect(channels.slack_id).must_equal 123
    expect(channels.name).must_equal "John"
    expect(channels.topic).must_equal "Smiths"
  end
  
  
  describe "user.list method" do
    
    it "creates array of users" do
      VCR.use_cassette("user") do
        expect(User.list).must_be_kind_of Array
        expect(User.list).wont_be_empty
      end
    end
    
    
  end
end