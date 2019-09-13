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
    it "returns an instance of HTTParty::Response" do
      VCR.use_cassette("recipient-get") do
        @new_users = SlackBot::Recipient.get("https://slack.com/api/users.list")
        @new_channels = SlackBot::Recipient.get("https://slack.com/api/conversations.list")
      end
      
      expect(@new_users).must_be_kind_of HTTParty::Response
      expect(@new_channels).must_be_kind_of HTTParty::Response
    end
    
    it "raises an Exception when a bad url is supplied" do
      expect{SlackBot::Recipient.get("https://slack.com/api/users.lis")}.must_raise Exception
    end
  end
  
  describe "send_message" do 
    before do
      @new_recipient = SlackBot::Recipient.new(slack_id: "UN69SF69K", name: "yitgop.yyhxox")
    end
    
    it "returns an instance of HTTParty::Reponse" do 
      VCR.use_cassette("recipient-send_message") do
        @success_message = @new_recipient.send_message(slack_id: "CMURA7JFM", message: "hello")
      end
      
      expect(@success_message).must_be_kind_of HTTParty::Response
    end
    
    it "raises an Exception when a bad slack id is supplied" do
      expect{@new_recipient.send_message(slack_id: "UN69SF69", message: "hello")}.must_raise Exception
    end
    
    it "raises an Exception no message is supplied" do
      expect{@new_recipient.send_message(slack_id: "UN69SF69K")}.must_raise Exception
    end
  end 
end
