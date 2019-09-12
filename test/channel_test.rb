require_relative "test_helper"

describe "Channel" do
  describe "#initialize" do
    before do
      @test_channel = Slack::Channel.new(name: "rubber duck", slack_id: "Ducks8", topic: "duck things", member_count: 138)
    end

    it "will return the attributes and its data type" do
      expect(@test_channel.name).must_equal "rubber duck"
      expect(@test_channel.slack_id).must_equal "Ducks8"
      expect(@test_channel.topic).must_equal "duck things"
      expect(@test_channel.member_count).must_equal 138

      expect(@test_channel).must_be_instance_of Slack::Channel
    end
  end
  describe "Channel.list method" do
    it "will return a list of channels" do
      VCR.use_cassette("channels_list") do
        @channel_array = Slack::Channel.list
      end

      expect(@channel_array[0]["name"]).must_be_instance_of String
      expect(@channel_array[0]["slack id"]).must_be_instance_of String
      expect(@channel_array[0]["topic"]).must_be_instance_of String
      expect(@channel_array[0]["member count"]).must_be_instance_of Integer
    end
  end

  describe "Channel details method" do
    before do
      @test_channel = Slack::Channel.new(name: "Gossip", slack_id: "FULLOFSECRETS", topic: "Everything true or false", member_count: 100)
    end
    it "will return details about the selected channel" do
      expect(@test_channel.details).must_equal "\nname: Gossip, slack_id: FULLOFSECRETS, topic: Everything true or false, member count: 100"
    end

    it "returns a string type for details" do
      expect(@test_channel.details).must_be_instance_of String
    end
  end
end
