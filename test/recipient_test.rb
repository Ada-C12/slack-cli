require_relative 'test_helper'

describe "Recipient class" do
  describe "#initialization" do
    it "creates a recipient instance" do
      new_recipient = SlackBot::Recipient.new(slack_id: "ABC123EFG", name: "yitgop")
      
      expect(new_recipient).must_be_kind_of SlackBot::Recipient
    end
    
    it "raises an argument error if slack_id is not a 9-character string" do
      expect{SlackBot::Recipient.new(slack_id: "A123456789", name: "yitgop")}.must_raise ArgumentError
      expect{SlackBot::Recipient.new(slack_id: 123456789, name: "yitgop")}.must_raise ArgumentError
    end
    
    it "raises an argument error if no name is supplied" do
      expect{SlackBot::Recipient.new(slack_id: "ABC123EFG")}.must_raise ArgumentError
    end
  end
  
end
