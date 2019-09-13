require_relative 'test_helper'

describe "Channel Class" do
  describe "New instance of Slack::Channel" do
    before do 
      VCR.use_cassette("lists_channels") do 
        @channel = Slack::Channel.new("CMUR2JTNX", "random", {"value"=>"", "creator"=>"", "last_set"=>0}, 7)
        @list = Slack::Channel.list
      end
    end
    
    it "is of the class Channel" do 
      expect(@channel.class).must_equal (Slack::Channel)
    end
    
    it "has a topic" do 
      expect(@channel.topic).must_equal ({"value"=>"", "creator"=>"", "last_set"=>0})
    end
    
    it "lists the channels" do 
      expect(@list.length).must_equal 4
      expect(@list).must_be_kind_of Array
      expect(@list[0]).must_be_kind_of Slack::Channel
      expect(@list[0].name).must_equal "random"
    end
  end
  
  describe "details" do
    before do 
      VCR.use_cassette("lists_channels") do 
        @channel = Slack::Channel.new("CMUR2JTNX", "random", {"value"=>"", "creator"=>"", "last_set"=>0}, 7)
      end
      
      it "returns a hash" do
        expect(@channel.details).must_be_kind_of Hash
      end
      
      it "has a slack_id" do
        expect(@channel.details["slack_id"]).must_equal "CMUR2JTNX"
      end
    end
  end
end