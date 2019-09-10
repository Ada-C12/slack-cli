require_relative "test_helper"

describe "User" do
  describe "User.list method" do
    it "will return a list of users" do
      VCR.use_cassette("users_list") do
        @user_array = Slack::User.list
      end

      expect(@user_array[0]["real name"]).must_be_instance_of String
      expect(@user_array[0]["user name"]).must_be_instance_of String
      expect(@user_array[0]["slack id"]).must_be_instance_of String
    end
  end
end
