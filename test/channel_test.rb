require_relative "test_helper"

describe "Channel" do
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
end
