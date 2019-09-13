require_relative "test_helper"
describe "channel" do
  before do
    VCR.use_cassette("recipient_test") do
      @workspace = Workspace.new
      @channels = Channel.load_all(@workspace.channel_url, ENV["SLACK_TOKEN"])
    end
  end
  describe "initialize" do
    before do
      @test_channel = Channel.new(id, name, details = "", topic = "", member_count = "")
      it "creates an instance of channel" do
        expect @test_channel.must_be_instance_of Channel
      end
      it "responds to variable names" do #we got this idea from Amal & Julia
        [:id, :name, :details, :topic, :member_count].each do |variable|
          expect(@test_channel).must_respond_to variable
        end
      end
    end
  end
  describe "self.load_all" do
    it "loads ids and names of all channels into an array" do
      expect @channels.must_be_instance_of Array
    end
  end
end
