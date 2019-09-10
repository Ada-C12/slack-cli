require_relative '../lib/recipient'
require_relative 'test_helper'

describe "Recipient" do
  
  describe "Initialize" do
    let(:recipient) {SlackCLI::Recipient.new(slack_id: "string", name: "hi")}
    it "should have a slack id and name" do
      expect(recipient.slack_id).must_be_instance_of String
      expect(recipient.name).must_be_instance_of String
    end
    
    it "should raise error if slack_id: is nil" do
      expect{ SlackCLI::Recipient.new(slack_id: nil, name: "hi") }.must_raise ArgumentError
    end
    
    it "should raise error if name: is nil " do
      expect{ SlackCLI::Recipient.new(slack_id: "hey", name: nil) }.must_raise ArgumentError
    end
  end  
  
  describe "get" do
    it "should be an instance of HTTParty" do
      # response = SlackCLI::Recipient.new(slack_id: "1", name: "Katie")
      # p response.get
      # p SlackCLI::Recipient.get
      VCR.use_cassette("recipient") do
        expect(SlackCLI::Recipient.get).must_be_instance_of HTTParty::Response
      end
    end
  end  
  
  
  # describe "get" do
  #   it "can find channels" do
  #     VCR.use_cassette("list_channels") do
  #       location = "Seattle"
  #       response = get_location(location)
  
  #       expect(response["Seattle"]).wont_be_nil
  #       expect(response["Seattle"][:lon]).must_equal "-122.3300624"
  #       expect(response["Seattle"][:lat]).must_equal "47.6038321"
  #     end
  #   end   
  
  #   it "will raise an exception if the search fails" do
  #     VCR.use_cassette("location_find") do
  #       location = ""
  #       expect {
  #       response = get_location(location)
  #     }.must_raise SearchError
  #   end
  # end
end
