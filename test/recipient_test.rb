require_relative '../lib/recipient'
require_relative 'test_helper'

describe "Recipient" do
  
  describe "Initialize" do
    let(:recipient) {SlackCLI::Recipient.new(slack_id: "string", name: "hi")}
    it "should have a slack id and name" do
      expect(recipient.slack_id).must_be_instance_of String
      expect(recipient.name).must_be_instance_of String
    end
    
    it "should raise error if slack_id: is nil" do
      expect{ SlackCLI::Recipient.new(slack_id: nil, name: "hi") }.must_raise ArgumentError
    end
    
    it "should raise error if name: is nil " do
      expect{ SlackCLI::Recipient.new(slack_id: "hey", name: nil) }.must_raise ArgumentError
    end
  end  
  
end