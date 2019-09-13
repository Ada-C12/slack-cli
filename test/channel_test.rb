require_relative 'test_helper'

 describe "Channel Class"do
 
  describe "self.list method" do
    it "should return true if the list was returned" do
      VCR.use_cassette("channel-tests") do
        response = Channel.list
        expect(response["ok"]).must_equal true
      end
    end
  end

  describe "self.printed_channels_list" do
  
    it "should contain a channel named general" do
      VCR.use_cassette("channel-tests") do
        channels_array = Channel.printed_channels_list
        channels_array.each do |channel|
          if channel["name"] == "general"
            assert (channel), "Expected true"
          end
        end
      end
    end
    
    it "should return an array of channels" do
      VCR.use_cassette("channel-tests") do
        channels_array = Channel.printed_channels_list
        expect(channels_array).must_be_kind_of Array
      end
    end
  end

  describe "self.select_channel_details method" do
    it "should return true four 'general' details" do
      VCR.use_cassette("channel-tests") do
        desired_person = Channel.select_channel_details("general")
        expect(desired_person["name"]).must_equal "general"
        expect(desired_person["topic"]).must_equal "This channel is for workspace-wide communication and announcements. All members are in this channel."
        expect(desired_person["name"]).must_be_kind_of String
        expect(desired_person["topic"]).must_be_kind_of String
      end
    end

    it "should return 'Not valid' statement if the Channel does not exist" do
      VCR.use_cassette("channel-tests") do
        desired_channel = Channel.select_channel_details("alsdjflai")
        expect(desired_channel).must_equal "Not a valid Channel name/Slack ID"
      end
    end
  end
end

