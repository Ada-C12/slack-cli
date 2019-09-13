require_relative 'test_helper'

describe "Recipient" do
  describe "send message" do
    it "raises API error for bad request" do
      VCR.use_cassette("api_request") do
        recipient = Recipient.new("id", "name")
        expect(recipient.send_message("Hi","dsdfsd")).must_equal false
        
      end
    end
  end
  
end