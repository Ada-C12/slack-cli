require_relative '../lib/channel'
require_relative 'test_helper'

describe "SlackCLI::Channel" do
  
  
  describe "list_channels" do
    
    it "should have a slack id and name" do
      expect(first_channel.slack_id).must_be_instance_of String
      expect(first_channel.name).must_be_instance_of String
    end
    
  end  
end