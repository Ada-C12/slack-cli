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
