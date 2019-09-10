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

  describe "self.list" do
    it "creates a list of all channels" do
      VCR.use_cassette("list_channels") do
        channel_list = SlackCLI::Channel.list

        expect(channel_list).must_be_instance_of Array
        expect(channel_list.first).must_be_instance_of SlackCLI::Channel
      end

    end

  end



  end

end
