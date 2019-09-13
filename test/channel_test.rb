require_relative 'test_helper'
require_relative '../lib/channel'
require_relative '../lib/recipient'
require 'pry'


describe "Channel class" do
  before do
    @channel = Channel.new(slack_id: 123, name: "Scotty", topic: "trekkie", member_count: 2)
  end
  
  it "instantiate a Channel object" do
    expect(@channel).must_be_instance_of Channel
    
  end
  
  it "assigns correct value to instance variables" do
    channel = Channel.new(slack_id: 123, name: "Scotty", topic: "trekkie", member_count: 2)
    
    expect(channel.slack_id).must_equal 123
    expect(channel.name).must_equal "Scotty"
    expect(channel.topic).must_equal "trekkie"
    expect(channel.member_count).must_equal 2

  end
  
  
  describe "channel.list method" do
    
    it "creates array of users" do
      VCR.use_cassette("channel") do
        expect(Channel.list).must_be_kind_of Array
        expect(Channel.list).wont_be_empty
      end
    end
    

  end



end