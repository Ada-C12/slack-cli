require_relative 'test_helper'

describe "User Class" do
  describe "New instance of Slack::User" do
    before do  
      VCR.use_cassette("lists_users") do 
        @user = Slack::User.new("UMTG0S5D0", "samantha.collares", "Samantha Collares")
        @user_test_list = @user.list
      end
    end
    
    it "is of the class User" do 
      expect(@user.class).must_equal (Slack::User)
    end
    
    it "lists the users" do 
      expect(@user_test_list).must_equal ["Slackbot", "Samantha Collares", "Sabrina Lowney", "Mariya Burrows", "Dianna Tingg", "Julia K", "Morgan Schuler", "Tiffany Chio"]
    end
    
    # it "provides details" do 
    #   expect(@user_test_list.details).must_equal 
    # end
  end
end