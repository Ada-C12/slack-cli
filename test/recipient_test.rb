require_relative '../lib/recipient'
require_relative 'test_helper'

describe "Recipient" do
  
  # 
  
  #Move Test to Child Classes
  # describe "get" do
  #   it "should be an instance of HTTParty" do
  #     # response = SlackCLI::Recipient.new(slack_id: "1", name: "Katie")
  #     # p response.get
  #     # p SlackCLI::Recipient.get
  #     VCR.use_cassette("recipient") do
  #       expect(SlackCLI::Recipient.get).must_be_instance_of HTTParty::Response
  #     end
  #   end
  # end  
  
  
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
