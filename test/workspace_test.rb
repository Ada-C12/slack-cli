require_relative "test_helper"

describe "Workspace class" do
  before do
    VCR.use_cassette("workspace") do
      @workspace = SlackCLI::Workspace.new
    end
  end
  describe "Initialize Workspace" do
    
    
    it "Creates a new workspace" do
      expect(@workspace).must_be_instance_of SlackCLI::Workspace
    end
    
    it "Generates an array of users" do
      expect(@workspace.users).must_be_instance_of Array
      expect(@workspace.users.first).must_be_instance_of SlackCLI::User
    end
    
    it "Generates an array of channels" do
      expect(@workspace.channels).must_be_instance_of Array
      expect(@workspace.channels.first).must_be_instance_of SlackCLI::Channel
    end
    
    it "initializes selected as nil" do
      expect(@workspace.selected).must_be_nil
    end
  end
  
  describe "find_user method" do
    it "Finds the correct user" do 
      user = @workspace.find_user("slackbot")
      
      expect(user).must_be_instance_of SlackCLI::User
      expect(user.real_name).must_equal "Slackbot"
      expect(user.slack_id).must_equal "USLACKBOT"
      
    end
    
    it "Returns nil if user isn't found" do
      user = @workspace.find_user("goblin")
      
      expect(user).must_be_nil
    end
  end
  
end

