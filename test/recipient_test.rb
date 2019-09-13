require_relative 'test_helper'

describe "Recipient class" do
  describe "initializer method" do
    it "can create an instance" do
      recipient = Recipient.new("USLACKBOT", "slackbot")

      expect(recipient).must_be_instance_of Recipient
      expect(recipient.id).must_equal "USLACKBOT"
      expect(recipient.name).must_equal "slackbot"
    end
  end

  # describe "get method" do
  #   it "can return a valid response" do
  #     BASE_URL = "https://slack.com/api/users.list"
  #     TOKEN = ENV["SLACK_TOKEN"]
  #     QUERY = {
  #       token: TOKEN
  #     }
  #     # VCR.use_cassette("workspace") do

  #     recipient = Recipient.new("USLACKBOT", "slackbot")
  #     recipient.get(BASE_URL, QUERY)

  #     expect(recipient.get).must_be_true
  #     # end
  #   end
  # end

  describe "details method" do
    it "will raise an error if this method is called" do
      recipient = Recipient.new("USLACKBOT", "slackbot")
      
      proc{recipient.details}.must_raise NotImplementedError
    end
  end

  describe "self.list method" do
    it "will raise an error if this method is called" do

      proc{Recipient.list}.must_raise NotImplementedError
    end
  end
end