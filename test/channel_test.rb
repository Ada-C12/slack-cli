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
    it "returns all the information about channel" do
      VCR.use_cassette("Channel_details") do
        channels = Slack::Channel.list_channels
        # channel = Channel.new("name", "topic", 1, 1234)
        channel = channels.first
        expect(channel.details).must_equal  "The channel name is #{channel.channel_name} and the slack id is #{channel.slack_id}"
        
        
      end
    end
  end 
  
  # # Send message test
  # # need to discuss this section
  # describe "Send message" do 
  #   it "sends a message to selected recepient" do 
  #     VCR.use_cassette("send_message") do
  #       channels = Slack::Channel.list_channels
  #       # channel = Channel.new("name", "topic", 1, 1234)
  #       channel = channels.first
  #       expect(channel.send_message).must_
  #     end
  
  # Test to check channel count
  describe "Channel list" do
    
    it "returns correct numbers of channel" do
      VCR.use_cassette("Channels_list") do
        channels = Slack::Channel.list_channels
        channel = channels.length
        expect(channel).must_equal  3
      end
    end
  end
end


# Yasmin's updates: but I put select method inside slack.rb? How to test this?

#     it "Select user" do
#       VCR.use_cassette("workspace") do
#         # Act
#         user = @users.select_user
#       # user.details
#       expected_output = "#{user}"
#       expect(user).must_equal expected_output
#       end
#     end
#   end
#  # added
#   describe "Workspace select_channel" do

#     it "Select channel " do
#       VCR.use_cassette("workspace") do
#         # Act
#         channel = @channels.select_channel
#       # user.details
#       expected_output = "#{channel}"
#       expect(channel ).must_equal expected_output
#       end
#     end
#   end
#  end