require_relative 'test_helper'

describe "Channel" do
  describe "initialize" do
    it "can be initialized as child class of Recipient" do
      slack_id = "TD83838H"
      name = "#random"
      topic = "random thoughts"
      member_count = "4"
      

      new_channel = SlackCLI::Channel.new(
        slack_id: slack_id, 
        name: name, 
        topic: topic, 
        member_count: member_count
      )

      expect(new_channel.class < SlackCLI::Recipient).must_equal true
    end
  end

  describe "self.list" do
    it "creates a list of all channels" do
      VCR.use_cassette("list_channels") do
        channel_list = SlackCLI::Channel.list

        expect(channel_list).must_be_instance_of Array
        expect(channel_list.first).must_be_instance_of SlackCLI::Channel
      end
    end
  end

  describe "details" do
    before do
      VCR.use_cassette("list_channels") do
        @channel_list = SlackCLI::Channel.list
      end
    end

    it "returns a string" do
      VCR.use_cassette("get_channel_info") do
        channel_details = @channel_list[2].details

        expect(channel_details).must_be_instance_of String
      end
    end

    it "returns accurate details about the channel" do
      VCR.use_cassette("get_channel_info") do
        channel_details = @channel_list[2].details

        expect(channel_details).must_include "CN9NG0YUE"
        expect(channel_details).must_include "random"
        expect(channel_details).must_include "Non-work banter and water cooler conversation"
        expect(channel_details).must_include "2"
        expect(channel_details).must_include "RANDOMNESS!!! YES!"
        expect(channel_details).must_include "false"
      end
    end
  end
end
