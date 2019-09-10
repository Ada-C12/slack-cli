require_relative 'test_helper'

describe "Channel" do
  describe "intialize" do
    it "creates a new instance of channel" do
      VCR.use_cassette("load_channels") do
        channels = Channel.get
        
        expect(channels[0]).must_be_kind_of Channel
        expect(channels).must_be_kind_of Array
      end
    end
  end
  
  describe "self.get" do
    it "has correct channel data" do
      VCR.use_cassette("load_channels") do
        channels = Channel.get
        
        expect(channels[0].name).must_equal "general"
        expect(channels[0].topic).must_equal "Company-wide announcements and work-based matters"
        expect(channels[0].member_count).must_equal 2
        expect(channels[0].slack_id).must_equal "CMTFYSFTL"
      end
    end
    
    it "has the correct number of channels" do
      VCR.use_cassette("load_channels") do
        channels = Channel.get
        
        expect(channels.length).must_equal 3
        
      end
    end
  end
  
  
end