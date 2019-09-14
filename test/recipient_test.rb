require_relative "test_helper"

describe "Recipient" do
  describe "initialize" do
    it "is an instance of Recipient" do 
      VCR.use_cassette("recipient-info") do
        recipient = Slack::Recipient.new(1, "spongebob")
        expect(recipient).must_be_kind_of Slack::Recipient
      end
    end    
    it "checks data structures at initialize" do
      VCR.use_cassette("recipient-info") do      
        recipient = Slack::Recipient.new(1, "spongebob")
        expect(recipient).must_be_kind_of Slack::Recipient
      end
    end
    
    
    describe "self.get" do 
      it "user returns instance of HTTParty" do
        VCR.use_cassette("recipient-info") do
          user = Slack::Recipient.get("https://slack.com/api/users.list")
          expect(user).must_be_kind_of HTTParty::Response
        end
      end 
      
      it "channel returns an instance of HTTParty" do
        VCR.use_cassette("recipient-info") do
          channel = Slack::Recipient.get("https://slack.com/api/conversations.list")
          expect(channel).must_be_kind_of HTTParty::Response
        end
      end 
      
      # describe "send message" do
      #   it "returns "
      # end
    end 
  end 
end
