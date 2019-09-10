require_relative 'test_helper'

describe "Channel" do
  before do
    @channel = Slack::Channel.new(
      slack_id: 1, 
      name: "taro", 
      topic: " ", 
      member_count: 1
    )
  end
  
  describe 'constructor' do
    it "will initialize an instance of User" do
      expect(@channel).must_be_kind_of Slack::Channel
    end
  end
  
  describe "details" do
    it "will return details for a user" do
      expect(@channel.details).must_equal "Slack id: 1, Name: taro, Topic:  , Member_count: 1"
    end
  end
  
  #maybe self.parse_response?
  
end
