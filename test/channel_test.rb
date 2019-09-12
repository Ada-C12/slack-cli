require_relative 'test_helper'
 
describe "Channel class" do 
  describe "Channel instantiation" do 
    
    it "returns array of Channel objects" do
      VCR.use_cassette("list_channels") do
        # Act
        channels = Slack::Channel.list_channels
        # Assert
        expect(channels).must_be_instance_of Array
        expect(channels[0]).must_be_instance_of Slack::Channel
      end 
    end
  end
end