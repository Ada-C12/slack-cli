require_relative "test_helper"
describe "channel" do
  before do
    VCR.use_cassette("recipient_test") do
      @workspace = Workspace.new
      @channels = Channel.load_all(@workspace.channel_url, ENV["SLACK_TOKEN"])
    end
  end
  describe "self.load_all" do
    it "loads ids and names of all channels into an array" do
      expect @channels.must_be_instance_of Array
    end
  end
end
