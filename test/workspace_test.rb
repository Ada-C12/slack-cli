require_relative "test_helper"

describe "Workspace" do
  describe "initialize" do 
    it "is an instance of Workspace" do
      VCR.use_cassette("workspace-info") do
        workspace = Slack::Workspace.new
        expect(workspace).must_be_kind_of Slack::Workspace
      end
    end
    
    it "checks data structures at initialize" do
      VCR.use_cassette("workspace-info") do
        workspace = Slack::Workspace.new
        expect(workspace.users).must_be_kind_of Array
      end 
    end
  end
  
  describe "select user" do  
    it "returns a string for a matching name" do
      VCR.use_cassette("workspace-info") do
        workspace = Slack::Workspace.new
        name_or_id = "slackbot"
        
        user = workspace.select_user(name_or_id)
        expect(user).must_be_kind_of String
      end
    end
    
    it "returns a string for a matching ID" do
      VCR.use_cassette("workspace-info") do
        workspace = Slack::Workspace.new
        name_or_id = "USLACKBOT"
        
        user = workspace.select_user(name_or_id)
        expect(user).must_be_kind_of String
      end
    end 
    
    it "returns nil for non-matching input" do
      VCR.use_cassette("workspace-info") do
        workspace = Slack::Workspace.new
        name_or_id = "nonexistentname"
        
        user = workspace.select_user(name_or_id)
        assert_nil user
      end 
    end 
  end
end 

describe "select channel" do  
  it "returns a string for a matching name" do
    VCR.use_cassette("workspace-info") do
      workspace = Slack::Workspace.new
      name_or_id = "random"
      
      channel = workspace.select_channel(name_or_id)
      expect(channel).must_be_kind_of String
    end
  end
  
  it "returns a string for a matching ID" do
    VCR.use_cassette("workspace-info") do
      workspace = Slack::Workspace.new
      name_or_id = "CMUR2JTNX"
      
      channel = workspace.select_channel(name_or_id)
      expect(channel).must_be_kind_of String
    end
  end 
  
  it "returns nil for non-matching input" do
    VCR.use_cassette("workspace-info") do
      workspace = Slack::Workspace.new
      name_or_id = "nonexistentname"
      
      channel = workspace.select_channel(name_or_id)
      assert_nil channel
    end 
  end
end
