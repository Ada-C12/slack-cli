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
  
  describe "#self.get" do
    before do
      VCR.use_cassette("recipient-get") do
        
        @new_users = SlackBot::Recipient.get("https://slack.com/api/users.list")
        @new_channels = SlackBot::Recipient.get("https://slack.com/api/conversations.list")
      end
    end
    
    it "returns an instance of HTTParty::Response" do
      expect(@new_users).must_be_kind_of HTTParty::Response
      expect(@new_channels).must_be_kind_of HTTParty::Response
    end
  end
end
