require_relative "test_helper"

describe "Channel class" do
  
  describe "Self.all method" do
    it "Returns a list of all channels" do
      
      VCR.use_cassette("channels") do
        all_channels = SlackCLI::Channel.all
        
        expect(all_channels).must_be_instance_of Array
        expect(all_channels.length).must_equal 4
        
        all_channels.each do |channel|
          expect(channel).must_be_instance_of SlackCLI::Channel
        end
      end
    end
    
    
  end
end
