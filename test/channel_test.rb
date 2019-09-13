require_relative "test_helper"

describe "Channel" do
  describe "initialize" do
    it "is an instance of Channel" do 
      channel = Slack::Channel.new("abc", "random", nil, 2)
      expect(channel).must_be_kind_of Slack::Channel
    end
    
    it "checks data structures at initialize" do
      channel = Slack::Channel.new("abc", "random", nil, 2)
      expect(channel.name).must_be_kind_of String
    end
  end 
  
  describe "self.list" do
    it "return an array of Channel Instances" do
      VCR.use_cassette("channel-info") do
        channel = Slack::Channel.list
        expect(channel).must_be_kind_of Array
      end
    end 
    
    # Test on hold check self.list
    # it "return an array of Channel Instances" do
    #   VCR.use_cassette("channel-info") do
    #     channel = Slack::Channel.list
    #     expect(channel.first).must_be_kind_of Slack::Channel
    #     expect(channel.last).must_be_kind_of Slack::Channel
    #   end
    # end 
  end
end
