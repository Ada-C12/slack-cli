require_relative 'test_helper'

describe "User" do
  describe "#initialization" do
    it "creates an instance of User" do
      new_user = SlackBot::User.new(slack_id: "ABC123EFG", name: "eagle", real_name: "yitgop")
      
      expect(new_user).must_be_kind_of SlackBot::User
    end
    
    it "raises an argument error if slack_id is not a 9-character string" do
      expect{SlackBot::User.new(slack_id: "ABC123EFGH", name: "eagle", real_name: "yitgop")}.must_raise ArgumentError
      expect{SlackBot::User.new(slack_id: 123456789, name: "eagle", real_name: "yitgop")}.must_raise ArgumentError
    end
    
    it "raises an argument error if no name is supplied" do
      expect{SlackBot::User.new(slack_id: "ABC123EFGH", real_name: "yitgop")}.must_raise ArgumentError
    end
  end
  
  describe "#list" do
    before do
      VCR.use_cassette("user-list") do
        @new_users = SlackBot::User.list
      end
    end
    
    it "returns an Array" do
      expect(@new_users).must_be_kind_of Array
    end
    
    it "returns an array of User Instances" do
      expect(@new_users.first).must_be_kind_of SlackBot::User
      expect(@new_users.last).must_be_kind_of SlackBot::User
    end
  end
end
