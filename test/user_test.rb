require_relative 'test_helper.rb'


describe "User class" do
  
  describe "User instantiation" do
    before do
      @users = Slack::User.users_list
    end
    
    it "is an instance of User" do
      expect(@users.first).must_be_kind_of Slack::User
    end
    
    it "returns an array of users" do      
      expect(@users).must_be_instance_of Array
    end
    
    it "will return the first user" do
      expect(@users.first.name).must_equal "slackbot"
      expect(@users.first.id).must_equal "USLACKBOT"
      expect(@users.first.real_name).must_equal "Slackbot"
    end
    
    
  end #end of describe user instantiation
end #end of class



