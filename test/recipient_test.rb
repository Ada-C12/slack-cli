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
  end
  
  describe "details" do
    it "raises an error if implementation attempted within Recipient class" do
      VCR.use_cassette("recipient-info") do      
        expect{ Slack::Recipient.details
        }.must_raise Exception
      end
    end
  end
  
  describe "self.list" do
    it "raises an error if implementation attempted within Recipient class" do
      VCR.use_cassette("recipient-info") do      
        expect{ Slack::Recipient.self.list
        }.must_raise Exception
      end
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
  end
  
  describe "send message" do
    it "raises an error if invalid ID is provided" do
      VCR.use_cassette("recipient-info") do
        
        slack_id = "INVALID"
        message = "I exist only in the ether."
        
        expect{ Slack::Recipient.send_message(slack_id, message)
        }.must_raise Exception
      end
    end 
    
    it "raises an error if response code isn't 200" do
      VCR.use_cassette("recipient-info") do
        
        slack_id = "USLACKBOT"
        message = "Woe upon your Cylon heart."
        { "ok": false, "error": "too_many_attachments" }

        expect{ Slack::Recipient.send_message(slack_id, message)
        }.must_raise Exception
      end
    end 
    
    it "returns an instance of HTTParty when successful" do
      VCR.use_cassette("recipient-info") do
        
        slack_id = "USLACKBOT"
        message = "Woe upon your Cylon heart."
        
        api_response = HTTParty.post("https://slack.com/api/chat.postMessage", query: {token: ENV['SLACK_API_TOKEN'], channel: slack_id, text: message})
        
        expect(api_response).must_be_kind_of HTTParty::Response
      end
    end 
  end
  
end
