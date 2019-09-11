require_relative "test_helper"

describe "User" do
  describe "#initialize" do
    before do
      @test_user = Slack::User.new(name: "johnk", slack_id: "UB39ALK", real_name: "John")
    end

    it "will return the attributes and its data type" do
      expect(@test_user.name).must_equal "johnk"
      expect(@test_user.slack_id).must_equal "UB39ALK"
      expect(@test_user.real_name).must_equal "John"

      expect(@test_user).must_be_instance_of Slack::User
    end
  end
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

  describe "User details method" do
    it "will return details about the selected user" do
      test_user = Slack::User.new(name: "Franky", slack_id: "FRANKRUS", real_name: "Frankenstein")
      expect(test_user.details).must_equal "\nreal name: Frankenstein, user name: Franky, slack_id: FRANKRUS"
    end
  end
end
