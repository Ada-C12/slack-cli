require_relative 'test_helper'

describe Slack do
  describe "Recipient class" do
    it "can send a valid message" do
      VCR.use_cassette("slack-posts") do
        response = Slack::Recipient.send_msg("Hey I can post messages!", "general")
        expect(response).must_equal true
      end
    end
  end
  
  it "will raise an error when given an invalid channel" do
    VCR.use_cassette("slack-posts") do
      exception = expect {
        Slack::Recipient.send_msg("This post should not work", "invalid-channel")
      }.must_raise Slack::SlackApiError
      
      expect(exception.message).must_equal 'Error when posting This post should not work to invalid-channel, error: channel_not_found'
    end
  end
end 