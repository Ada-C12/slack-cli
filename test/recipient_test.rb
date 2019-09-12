require_relative "test_helper"

describe "Recipient class" do
  let(:recipient) { SlackCLI::Recipient.new(123, "test") }
  
  describe "Initialize method" do
    it "Creates an instance of recipient" do
      expect(recipient).must_be_instance_of SlackCLI::Recipient
      expect(recipient.slack_id).must_equal 123
      expect(recipient.name).must_equal "test"
    end
  end
  
  describe "details" do
    it "Raises an exception for the details method" do
      expect{recipient.details}.must_raise NotImplementedError
    end
  end
  
  describe "self.all" do
    it "Raises an exception for the self.all method" do
      expect{SlackCLI::Recipient.all}.must_raise NotImplementedError
    end
  end
end
