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
end
