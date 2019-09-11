require_relative '../lib/channel'
require_relative 'test_helper'

describe "Channel" do
  
  #Not Passing - Wrong Number of Arguments
  describe "Initialize" do
    let(:first_channel) {SlackCLI::Channel.new(slack_id: "string", name: "hi", topic: "string", member_count: 4)}
    it "should have a slack id and name" do
      expect(first_channel.slack_id).must_be_instance_of String
      expect(first_channel.name).must_be_instance_of String
    end
    
    # it "should raise error if slack_id: is nil" do
    #   expect{ SlackCLI::Channel.new(slack_id: nil, name: "hi",  topic: "string", member_count: 4) }.must_raise ArgumentError
    # end
    
    # it "should raise error if name: is nil " do
    #   expect{ SlackCLI::Channel.new(slack_id: "hey", name: nil,  topic: "string", member_count: 4) }.must_raise ArgumentError
    # end
  end  
end