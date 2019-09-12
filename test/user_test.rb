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
  end
  
  describe "list" do
    before do  
      VCR.use_cassette("lists_users") do 
        @user = Slack::User.new("UMTG0S5D0", "samantha.collares", "Samantha Collares")
        @user_test_list = @user.list
        @first_user = @user_test_list[1]
      end
    end
    
    it "lists the users" do 
      expect(@user_test_list.length).must_equal 8
      expect(@first_user).must_be_a_kind_of Hash
      expect(@first_user)["slack_id"].must_equal "UMTG0S5D0"
      expect(@first_user)["name"].must_equal "samantha.collares"
      expect(@first_user)["real_name"].must_equal "Samantha Collares"
    end
  end  
  
  describe "details" do    
    before do  
      VCR.use_cassette("user_details") do 
        @user = Slack::User.new("UMTG0S5D0", "samantha.collares", "Samantha Collares")
        @user_test_list = @user.list
        @first_user = @user_test_list[1]
      end
    end
    
    it "provides details" do 
      expect(@user.details).must_equal ({"slack_id"=> "UMTG0S5D0", "name"=> "samantha.collares", "real_name"=> "Samantha Collares" })
    end
    
    # it "provides details" do 
    #   expect(@user_test_list.details).must_equal 
    # end
  end # desscribe the class end
end
