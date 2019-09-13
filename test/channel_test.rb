require_relative 'test_helper.rb'


describe "Channel class" do
  
  describe "Channel instantiation" do
    before do
      VCR.use_cassette("Channel_instantiation") do
      @channels = Slack::Channel.channels_list
    end
  end
    
    it "is an instance of Channel" do
      expect(@channels.first).must_be_kind_of Slack::Channel
    end
    
    it "returns an array of channels" do      
      expect(@channels).must_be_instance_of Array
    end
    
    it "will return the first channel" do
      expect(@channels.first.name).must_equal "pupper-pics"
      expect(@channels.first.id).must_equal "CMUPUL1R9"
      expect(@channels.first.topic).must_equal "doggy photoshoot"
      expect(@channels.first.member_count).must_equal 6
    end

    
  end #end of describe channel instantiation
end #end of class



