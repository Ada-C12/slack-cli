require_relative "test_helper"
# VCR.use_cassette("location_find") do  

describe "Workspace Class" do
  
  describe "Workspace Instantiation" do
    before do
      VCR.use_cassette("users_list") do
        @workspace = Slack::Workspace.new 
      end
    end
    
    it "will haver 7 users" do
      expect(@workspace.users.count).must_equal 7
    end
    
    it "knows that each user is an instance of user" do
      expect(@workspace.users.first).must_be_instance_of Slack::User
    end
    
    it "will be an instance of channel" do
      expect(@workspace.channels.count).must_equal 4
    end 
    
    it "each channel will be an instance of channel" do
      expect(@workspace.channels.first).must_be_instance_of Slack::Channel
    end 
  end #end of describe workspace instantiation
  
  describe "Workspace's Select User" do
    before do
      VCR.use_cassette("select_users") do
        @workspace = Slack::Workspace.new 
      end
    end
    
    it "will find the selected user in the list" do
      this_user = @workspace.select_user("dnsanche")
      expect(this_user).must_equal true
      this_user = @workspace.select_user("USLACKBOT").must_equal true
    end
    
    it "will return false if username entered is invalid" do
      this_user = @workspace.select_user("GDFG")
      expect(this_user).must_equal false
    end
  end #end of workspace select user block
  
  describe "Workspace's Select Channel" do
    before do
      VCR.use_cassette("channels_list") do
        @workspace = Slack::Workspace.new 
      end
    end
    
    it "will find the selected channel in the list" do
      this_channel = @workspace.select_channel("random")
      expect(this_channel).must_equal true
      this_channel = @workspace.select_channel("CMUPUL1R9").must_equal true
    end
    
    it "will return false if username entered is invalid" do
      this_channel = @workspace.select_channel("GDFG")
      expect(this_channel).must_equal false
    end
    

    
  end #end for workspace select channel
  
  
end #end of workspace class

# the name is the name if the cassete we want to specify. If we don't have that cassete created, it will be created automatically.
# i'm using location based on the example of the class, but we need to update it.

