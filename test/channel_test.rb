require_relative 'test_helper'

describe "Channel" do
  describe "initialize" do
    it "can be initialized as child class of Recipient" do
      slack_id = "TD83838H"
      name = "#random"
      topic = "random thoughts"
      member_count = "4"
      

      new_channel = SlackCLI::Channel.new(
        slack_id: slack_id, 
        name: name, 
        topic: topic, 
        member_count: member_count
      )

      expect(new_channel.class < SlackCLI::Recipient).must_equal true
    end



  end

end
