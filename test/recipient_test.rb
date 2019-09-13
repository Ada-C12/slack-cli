require_relative "test_helper"
require 'dotenv'
require 'httparty'

Dotenv.load

describe "Recipient" do
  before do
    slack_id = "1232452"
    name = "Dominique"
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
end
