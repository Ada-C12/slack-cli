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
    it "returns an instance of user" do
      VCR.use_cassette("workspace-info") do
        workspace = Slack::Workspace.new
        name_or_id = "slackbot"
        
        user = workspace.select_user(name_or_id)
        expect(user).must_be_kind_of Hash
      end
    end 
  end 
end 
