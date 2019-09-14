require_relative 'test_helper'

describe Slack do
  describe "Recipient class" do
    
    it "can send a valid message to the channel" do
      VCR.use_cassette("slack-posts") do
        response = Slack::Recipient.send_msg("Hey I can post messages!", "general")
        expect(response).must_equal true
      end
    end
    
    
    it "will raise an error when given an invalid channel" do
      VCR.use_cassette("slack-posts") do
        exception = expect {
          Slack::Recipient.send_msg("This post should not work", "invalid")
        }.must_raise Slack::SlackApiError
        
        expect(exception.message).must_equal 'Error when posting This post should not work to invalid, error: channel_not_found'
      end
    end
    
    it "can send a valid message to the user" do
      VCR.use_cassette("slack-posts") do
        response = Slack::Recipient.send_msg("Hey I can post messages!", "UN5R3NYUU")
        expect(response).must_equal true
      end
    end
  end
end 