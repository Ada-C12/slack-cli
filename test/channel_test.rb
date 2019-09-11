require_relative "test_helper"

describe "Class Channel" do
  it "is an instance of Channel" do 
    channel = Slack::Channel.new("abc", "random", topic = nil, member_count = 2)
    expect(channel).must_be_kind_of Slack::Channel
  end
  
  it "checks data structures at initialize" do
    channel = Slack::Channel.new("abc", "random", topic = nil, member_count = 2)
    expect(channel.name).must_be_kind_of String
  end
end 

describe "method self.list" do 
  it "is an instance of HTTParty" do
    VCR.use_cassette("channel-info") do
      channel_list = Slack::Channel.list
      expect(channel_list).must_be_kind_of Array
    end
  end 
end
