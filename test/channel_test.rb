require_relative 'test_helper'

describe "Channel Class" do
  describe "New instance of Slack::Channel" do
    before do 
      VCR.use_cassette("lists_channels") do 
        # url = "https://slack.com/api/channels.list"
        # KEY = ENV["SLACK_TOKEN"]
        # query_parameters = {
        #   token: KEY
        # }
        # channel_objects = self.get(url, query: query_parameters)
        channel = Slack::Channel.new(14, "Morgan", "general", 5)
        @test_list = channel.list
      end
    end
    it "lists the channels" do 
      expect(@test_list).must_equal ["random", "turkey", "slack-cli", "general"]
    end
  end
end