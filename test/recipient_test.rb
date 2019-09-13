require_relative "test_helper"

describe "Recipient class" do
  let(:recipient) { SlackCLI::Recipient.new(123, "test") }
  
  describe "initialize method" do
    it "Creates an instance of recipient" do
      expect(recipient).must_be_instance_of SlackCLI::Recipient
      expect(recipient.slack_id).must_equal 123
      expect(recipient.name).must_equal "test"
    end
  end
  
  describe "self.get method" do
    it "Raises an exception if code isn't 200 or ok isn't true" do
      VCR.use_cassette("bad_recipient") do
        expect{SlackCLI::Recipient.get("test")}.must_raise SlackCLI::SlackAPIError
      end
    end
  end
  
  describe "self.all method" do
    it "Raises an exception for the self.all method" do
      expect{SlackCLI::Recipient.all}.must_raise NotImplementedError
    end
  end
end
