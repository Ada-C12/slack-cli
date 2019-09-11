require_relative 'test_helper'

describe "Channel" do
  describe "initialize" do
    it "establishes the base attributes when instantiated" do
      channel = Slack::Channel.new(channel_name:"#random", topic:"pupper toes", member_count: 6, slack_id:"CMUPUL1R9")
      [:channel_name, :topic, :member_count, :slack_id].each do |attribute|
        expect(channel).must_respond_to attribute
      end
    end
  end
end