require_relative 'test_helper'

describe "Channel" do
  describe "#initialization" do
    it "creates an instance of Channel" do
      new_channel = SlackBot::Channel.new(slack_id: "ABC123EFG", name: "yitgop", topic: "stuff", member_count: 4)
      
      expect(new_channel).must_be_kind_of SlackBot::Channel
    end
    
    it "raises an argument error if slack_id is not a 9-character string" do
      expect{SlackBot::Channel.new(slack_id: "A123456789", name: "yitgop", topic: "stuff", member_count: 4)}.must_raise ArgumentError
      expect{SlackBot::Channel.new(slack_id: 123456789, name: "yitgop", topic: "stuff", member_count: 4)}.must_raise ArgumentError
    end
    
    it "raises an argument error if no name is supplied" do
      expect{SlackBot::Channel.new(slack_id: "ABC123EFG", topic: "stuff", member_count: 4)}.must_raise ArgumentError
    end
    
    it "creates instance of Channel without topic argument" do 
      new_channel = SlackBot::Channel.new(slack_id: "ABC123EFG", name: "yitgop", member_count: 4)
      
      expect(new_channel).must_be_kind_of SlackBot::Channel
    end
    
    
  end
end
