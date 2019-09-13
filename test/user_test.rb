require_relative 'test_helper'

describe "User" do
  before do
    @user = Slack::User.new(
      slack_id: 1, 
      name: "taro", 
      real_name: "taro the corgi", 
      status_text: "borking", 
      status_emoji: ":boop:"
    )
  end
  
  describe 'constructor' do
    it "will initialize an instance of User" do
      expect(@user).must_be_kind_of Slack::User
    end
  end
  
  describe "details" do
    it "will return details for a user" do
      expect(@user.details).must_equal "Slack id: 1, Name: taro, Real name: taro the corgi, Status Text: borking, Status Emoji: :boop:"
    end
  end
end
