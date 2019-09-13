require_relative 'test_helper'

describe Slack::Recipient do
  describe 'constructor' do
    it 'takes and saves a slack id and name' do
      slack_name = "taro"
      slack_id = 1
      
      recipient = Slack::Recipient.new(slack_id: slack_id, name: slack_name)
      
      expect(recipient).must_be_kind_of Slack::Recipient
      expect(recipient.slack_id).must_equal slack_id
      expect(recipient.name).must_equal slack_name
    end
  end
  
  describe "self.get" do    
    it "will raise an error when invalid token" do
      VCR.use_cassette("recipient_test") do
        exception = expect{
          Slack::Recipient.get("https://slack.com/api/users.list", query: {token: "bad token"})
        }.must_raise SlackApiError
        
        expect(exception.message).must_equal "Invalid API request with code 200 and message invalid_auth."
      end
    end
    
    it "will raise an error when invalid url" do
      VCR.use_cassette("recipient_test") do
        exception = expect{
          Slack::Recipient.get("https://slack.com/api/users.invalid", query: {token: ENV['SLACK_TOKEN']})
        }.must_raise SlackApiError
        
        expect(exception.message).must_equal "Invalid API request with code 200 and message unknown_method."
      end
    end
  end
  
  describe "abstract methods" do
    before do
      @slack_name = "taro"
      @slack_id = 1
      @recipient = Slack::Recipient.new(slack_id: @slack_id, name: @slack_name)
    end
    
    it "details method raises a NotImplementedError if invoked directly" do
      expect{@recipient.details}.must_raise NotImplementedError
    end
    
    it "parse_response method raises a NotImplementedError if invoked directly" do
      expect{Slack::Recipient.parse_response(nil)}.must_raise NotImplementedError
    end
  end
end
