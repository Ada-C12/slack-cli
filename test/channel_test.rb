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
  
  describe "Channel details" do 
    it "retuen all the information about channel" do
      VCR.use_cassette("Channel_details") do
        channels = Slack::Channel.list_channels
        # channel = Channel.new("name", "topic", 1, 1234)
        channel = channels.first
        expect(channel.details).must_equal  "The channel name is #{channel.channel_name} and the slack id is #{channel.slack_id}"
        
        
      end
    end
  end 
  
  
end