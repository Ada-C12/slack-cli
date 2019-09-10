require_relative 'test_helper'

describe "User" do
  describe "intialize" do
    it "creates a new instance of user" do
      VCR.use_cassette("load_users") do
        users = User.get
        
        expect(users[0]).must_be_kind_of User
        expect(users).must_be_kind_of Array
      end
    end
  end
  
  describe "self.get" do
    it "has correct user data" do
      VCR.use_cassette("load_users") do
        users = User.get
        
        expect(users[0].name).must_equal "slackbot"
        expect(users[0].real_name).must_equal "Slackbot"
        expect(users[0].status_text).must_be_nil
        expect(users[0].status_emoji).must_be_nil
        expect(users[0].slack_id).must_equal "USLACKBOT"
      end
    end
    
    it "has the correct number of users" do
      VCR.use_cassette("load_users") do
        users = User.get
        
        expect(users.length).must_equal 3
        
      end
    end
  end
  
  
end