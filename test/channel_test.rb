require_relative 'test_helper'
require_relative '../lib/channel'
require_relative '../lib/recipient'
require 'pry'
require 'httparty'
require  'dotenv'

Dotenv.load



describe "Channel class" do
  
  
  it "instantiate the Channel class" do
    
    expect(Channel.new(slack_id: 123, name: "John", topic: "Smiths", member_count: 4, purpose: "Whovians")).must_be_instance_of Channel
    
  end
  
  it "assigns correct value to instance variables" do
    channels = Channel.new(slack_id: 123, name: "John", topic: "Smiths", member_count: 4, purpose: "Whovians")
    
    expect(channels.slack_id).must_equal 123
    expect(channels.name).must_equal "John"
    expect(channels.topic).must_equal "Smiths"
    expect(channels.member_count).must_equal 4
  end
  
  
  describe "channel.list method" do
    
    it "creates array of channels" do
      VCR.use_cassette("channel") do
        expect(Channel.list).must_be_kind_of Array
        expect(Channel.list).wont_be_empty
      end
    end
    
    
  end
end