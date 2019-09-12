require_relative 'test_helper'

describe "Recipient" do
  describe "initialize" do
    it "can be initialized with an ID and a name" do
      slack_id = "TD83838H"
      name = "SlackBot"

      new_recipient = SlackCLI::Recipient.new(slack_id: slack_id, name: name)

      expect(new_recipient).must_be_instance_of SlackCLI::Recipient
    end
  end

  describe "self.get" do
    it "raises an error if the API returns an error response" do
      VCR.use_cassette("recipient_gets") do
        response = 
      end
    end
  end

end
