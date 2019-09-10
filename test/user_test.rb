require_relative "test_helper"

describe "User class" do
  
  describe "Self.all method" do
    it "Returns a list of all users" do
      
      VCR.use_cassette("users") do
        all_users = SlackCLI::User.all
        
        expect(all_users).must_be_instance_of Array
        
        all_users.each do |user|
          expect(user).must_be_instance_of SlackCLI::User
        end
      end
    end
    
    
  end
end
