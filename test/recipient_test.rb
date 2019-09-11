require_relative "test_helper"

describe "Class Recipient" do
  it "is an instance of Recipient" do 
    recipient = Slack::Recipient.new(1, "spongebob")
    expect(recipient).must_be_kind_of Slack::Recipient
  end
  
  it "checks data structures at initialize" do
    recipient = Slack::Recipient.new(1, "spongebob")
    expect(recipient).must_be_kind_of Slack::Recipient
  end
end 

describe "method self.get" do 
  it "is returns instance of HTTParty" do
    VCR.use_cassette("recipient-info") do
      user = Slack::Recipient.get("https://slack.com/api/users.list")
      expect(user).must_be_kind_of HTTParty::Response
    end
  end 
  
  it "is returns an instance of HTTParty" do
    VCR.use_cassette("recipient-info") do
      channel = Slack::Recipient.get("https://slack.com/api/conversations.list")
      expect(channel).must_be_kind_of HTTParty::Response
    end
  end 
end
