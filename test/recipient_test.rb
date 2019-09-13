require_relative 'test_helper'

describe "Recipient Class" do
  describe "Constructor" do
    it "Should return a recipient class instance" do
      #Expect recipient.new 
      slack_id = 1
      name = "Dom"
      slacker = Recipient.new(slack_id, name)
      expect(slacker.slack_id).must_equal slack_id
      expect(slacker.name).must_equal "Dom"
    end
  end
  
  xdescribe "send message method" do
    it "Should send a message to"
  end
end