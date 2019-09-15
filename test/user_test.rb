require_relative "test_helper"

describe "User" do 
  describe "self.list" do 
    it "return an array" do
      VCR.use_cassette("user-info") do
        user_list = Slack::User.list
        expect(user_list).must_be_kind_of Array
      end
    end 
    describe "initialize" do
      it "is an instance of User" do 
        user = Slack::User.new("CS50", "spongebob", "bob smith")
        expect(user).must_be_kind_of Slack::User
      end
      
      it "checks data structures at initialize" do
        user = Slack::User.new("CS50", "spongebob", "bob smith")
        expect(user.real_name).must_be_kind_of String
      end
    end 
  end

end
