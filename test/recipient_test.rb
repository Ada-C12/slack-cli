require_relative 'test_helper'

describe Recipient do
  before do
    @slack_id = "ABC123"
    @name = "tofu"
  end

  describe "Constructor"  do
    it "can construct a Recipient instance" do
      expect (Recipient.new(slack_id: @slack_id, name: @name)).must_be_instance_of Recipient
    end
    
    it "can access slack_id and name attributes" do
      recipient = Recipient.new(slack_id: @slack_id, name: @name)
      
      expect (recipient.name).must_equal @name
      expect (recipient.slack_id).must_equal @slack_id
    end
  end
  
  describe "#send_message method" do    
  end
  
  describe ".get method" do
    before do
      Dotenv.load
      @url = 'https://slack.com/api/channels.list'
      @params = { token: ENV["SLACK_API_KEY"] }
    end
    
    it 'returns a hash' do
      VCR.use_cassette('Recipient_get') do
        response = Recipient.get(@url, @params)
        expect(response).must_be_instance_of Hash
        expect(response['channels']).must_be_instance_of Array
      end
    end

    it "raises SlackApiError if response status is not success" do 
      VCR.use_cassette('Recipient_get_bad_requests') do
        expect {Recipient.get(@url, {})}.must_raise Recipient::SlackApiError
      end
    end
  end
end
