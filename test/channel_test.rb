require_relative "test_helper"
describe "channel" do
  describe "instantiate a channel" do
    before do
      @channel = Channel.new("https://slack.com/api/conversations.list", ENV["SLACK_TOKEN"])
      Channel.load_all
    end
  end
end
