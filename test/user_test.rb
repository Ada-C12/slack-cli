require_relative "test_helper"

describe "User class" do
  describe "initialize method" do
    it "Initializes a new user" do
      user = SlackCLI::User.new(slack_id: 123, name: "test", real_name: "Test Name")
      
      expect(user).must_be_instance_of SlackCLI::User
      expect(user.slack_id).must_equal 123
      expect(user.name).must_equal "test"
      expect(user.real_name).must_equal "Test Name"
    end
  end
  
  describe "get_message_history" do
    it "Gets message history for a user" do
      VCR.use_cassette("users") do
        all_users = SlackCLI::User.all
        result = all_users.first.get_message_history
        
        expect(result.code).must_equal 200
        expect(result["ok"]).must_equal true
      end
    end
    
    it "Raises an error for IM list if code isn't 200 or ok isn't true" do
      VCR.use_cassette("bad_ims_list") do
        all_users = SlackCLI::User.all
        
        expect{all_users.first.get_message_history}.must_raise SlackCLI::SlackAPIError
      end
    end
    
    it "Raises an error for Converstaions list if code isn't 200 or ok isn't true" do
      VCR.use_cassette("bad_conversations_list") do
        all_users = SlackCLI::User.all
        
        expect{all_users.first.get_message_history}.must_raise SlackCLI::SlackAPIError
      end
    end
  end
  
  describe "Self.all method" do
    it "Returns a list of all users" do      
      VCR.use_cassette("users") do
        all_users = SlackCLI::User.all
        
        expect(all_users).must_be_instance_of Array
        expect(all_users.length).must_equal 8
        
        all_users.each do |user|
          expect(user).must_be_instance_of SlackCLI::User
        end
      end
    end
  end
end
