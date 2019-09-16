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
  
  # Send message test
  describe "Send message" do 
    it "sends a message to selected recipient" do 
      VCR.use_cassette("send_message") do
        users = Slack::User.list_users
        user = users.first
        expect(user.send_message("popcorn")).must_equal true 
      end
    end
  end
  
  # Test to check user count
  describe "User list" do
    it "returns correct numbers of users" do
      VCR.use_cassette("users_list") do
        users = Slack::User.list_users
        users = users.length
        expect(users).must_equal  3
      end
    end
  end
  
  describe "Select user" do
    it "returns the selected user" do
      VCR.use_cassette("users_list") do
        user = Slack::User.select_user("slackbot")
        # user.details
        expected_output = "#{user}"
        expect(user.user_name).must_equal "USLACKBOT"
      end
    end
    
    it "raises an Argument for invalid selected user" do
      VCR.use_cassette("users_list") do
        user = Slack::User.select_user("slackbot")
        expect {
          user.user_name("hgjguv")
        }.must_raise ArgumentError
      end
    end
  end 
end