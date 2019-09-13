require_relative "test_helper"

describe "recipient" do
  before do
    VCR.use_cassette("recipient_test") do
      @workspace = Workspace.new
      @recipients = Recipient.load_all(@workspace.user_url, ENV["SLACK_TOKEN"])
    end
  end
  describe "self.load_all" do
    it "loads ids and names of all recipients into an array" do
      expect @recipients.must_be_instance_of Array
    end
  end
end
