require_relative "test_helper"
require 'dotenv'
require 'httparty'

Dotenv.load

describe "Recipient" do
  before do
    slack_id = "UMTGXDXD0"
    name = "dom_taylor"
    @recipient = Recipient.new(slack_id, name)
  end

  describe "Recipient instantiation" do
    it "is an instance of Recipient " do
      expect(@recipient).must_be_kind_of Recipient
    end
  end

  describe "details" do
    it "raises an error if invoked directly (without subclassing)" do
      url = "https://slack.com/api/channels.list"
      query = {token: 347358792354398}

      expect {
      @recipient.details
      }.must_raise NotImplementedError
    end
  end

  describe "self.list" do
    it "raises an error if invoked directly (without subclassing)" do
      
      expect {
        Recipient.list
        }.must_raise NotImplementedError
    end
  end

  describe "send message" do
    it "returns true if a message is sent" do
      VCR.use_cassette("recipient") do
        expect(@recipient.send_message("hello")).must_equal true
      end
    end

    it "raises an error when message isn't posted" do
      new_recipient = Recipient.new("234245t56356", "fgererg")

      VCR.use_cassette("recipient") do
        expect{new_recipient.send_message("hello")}.must_raise SlackAPIError
      end
    end 
  end
end
