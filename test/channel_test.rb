require_relative 'test_helper'

describe Channel do
  before do
    @slack_id = "ABC123"
    @name = "tofu"
    @topic = "pets"
    @member_count = 2
  end
  
  describe "Constructor"  do
    it "can construct a Channel instance" do
      expect (
        Channel.new(slack_id: @slack_id, name: @name, topic: @topic, member_count: @member_count)
      ).must_be_instance_of Channel
    end
    
    it "can access slack_id and name attributes" do
      channel = Channel.new(slack_id: @slack_id, name: @name, topic: @topic, member_count: @member_count)
      
      expect (channel.name).must_equal @name
      expect (channel.slack_id).must_equal @slack_id
      expect (channel.topic).must_equal @topic
      expect (channel.member_count).must_equal @member_count
    end
  end
  
  describe "#details method" do    
  end
  
  describe " .list method" do
  end
end