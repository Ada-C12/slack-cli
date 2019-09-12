require_relative 'test_helper'
#require 'pry'

describe "User Class" do
  describe "New instance of Slack::User" do
    before do  
      VCR.use_cassette("lists_users") do 
        @user = Slack::User.new("UMTG0S5D0", "samantha.collares", "Samantha Collares")
        @users = Slack::User.list
        #binding.pry
      end
    end
    
    it "is of the class User" do 
      VCR.use_cassette("lists_the_class") do 
        expect(@user.class).must_equal (Slack::User)
      end
    end
    
    # before do  
    #   VCR.use_cassette("lists_users") do 
    #     testing_list = User.self.list
    #     testing_object = testing_list[1]
    #     # @user = Slack::User.new(
    #     # user_basic = ["UMTG0S5D0", "samantha.collares", "Samantha Collares"]
    #     # @user_test_list = @user.list
    #     # @first_user = @user_test_list[1]
    #   end
    # end
    
    it "lists the users" do
      VCR.use_cassette("lists_the_users_length") do 
        expect(@users.length).must_equal 8
        #end
      end
    end
    
    it "describes the user" do
      VCR.use_cassette("describes_users") do 
        expect(@user).must_be_kind_of Slack::User
        expect(@user.slack_id).must_equal "UMTG0S5D0"
        expect(@user.name).must_equal "samantha.collares"
        expect(@user.real_name).must_equal "Samantha Collares"
      end
    end  
    
    describe "details" do    
      before do  
        VCR.use_cassette("user_details") do 
          @user = Slack::User.new("UMTG0S5D0", "samantha.collares", "Samantha Collares")
        end
      end
      
      it "provides details" do 
        # binding.pry
        expect(@user.details).must_equal ({"slack_id"=> "UMTG0S5D0", "name"=> "samantha.collares", "real_name"=> "Samantha Collares" })
      end
    end
  end
end
