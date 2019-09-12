
require_relative 'test_helper'


describe "SlackCLI::Channel" do
  describe "list_channels" do
    it "should be a list of channels" do
      VCR.use_cassette("list_channels") do
        expect(SlackCLI::Channel.list_channels.first).must_be_instance_of SlackCLI::Channel
      end
    end
  end
  
  # it "should be a channel" do
  # end
  
  # it "should have appropriate attributes" do
  # end
  
  # it "should have id respond to a string" do
  # end
  
  it "Should return an Array" do
    VCR.use_cassette("list_channels") do
      expect(SlackCLI::Channel.list_channels).must_be_instance_of Array
    end
  end  
end



#Unsure if we can actually test this
# it "Should raise error when reponse is nil" do
#   (SlackCLI::Channel.list_channels response = HTTParty.get("https://slack.com/api/channels.list?token=#{xoxo-87634-2}")
#   response.must_raise StandardError
# end
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

# let(:channel_list) {}