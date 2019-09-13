require_relative 'test_helper'
describe "User class" do 
  describe "User instantiation" do 
    
    it "returns array of User objects" do
      VCR.use_cassette("list_users") do
        # Act
        users = Slack::User.list_users
        # Assert
        expect(users).must_be_instance_of Array
        expect(users[0]).must_be_instance_of Slack::User
      end 
    end
  end
  
  describe "User details" do 
    
    before do 
      VCR.use_cassette("list_users") do
        @users = Slack::User.list_users
      end 
    end
    
    it "returns user details: username, name, slack_id" do 
      user = @users.first 
      # user.details 
      expected_output = "The name is #{user.name}, the user name is #{user.user_name}, and the slack id is #{user.slack_id}"
      expect(user.details).must_equal expected_output 
    end
  end 

  # send message test
  describe "Send message" do 
end
