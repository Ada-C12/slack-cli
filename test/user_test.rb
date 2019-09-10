require_relative 'test_helper'

describe Slack::Recipient do
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
      expect(@user.details).must_equal "Slack id: 1, Name: taro, Real name: taro the corgi, Status: borking :boop:"
    end
  end
  
  #maybe self.parse_response?
  
end




# before do
#   VCR.use_cassette("user_tests") do
#     URL = "https://slack.com/api/users.list" 
#     token = ENV['SLACK_TOKEN']

#     @users_array = Slack::User.get(URL, query: {token: token})
#   end
# end