require_relative 'test_helper'

describe "Channel Class" do
  describe "New instance of Slack::Channel" do
    before do 
      VCR.use_cassette("lists_channels") do 
        @channel = Slack::Channel.new("CMUR2JTNX", "random", {"value"=>"", "creator"=>"", "last_set"=>0}, 7)
        @test_list = @channel.list
      end
    end
    
    it "is of the class Channel" do 
      expect(@channel.class).must_equal (Slack::Channel)
    end
    
    it "lists the channels" do 
      expect(@test_list).must_equal ["random", "turkey", "slack-cli", "general"]
    end
    
    # it "provides details" do 
    #   expect(@test_list.details).must_equal 
    # end
  end
end