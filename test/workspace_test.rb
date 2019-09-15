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
  
  describe "select" do  
    it "returns a string for a matching user name" do
      VCR.use_cassette("workspace-info") do
        workspace = Slack::Workspace.new
        name_or_id = "slackbot"
        
        user = workspace.select(name_or_id)
        expect(user).must_be_kind_of String
      end
    end
    
    
    it "returns a string for a matching channel name" do
      VCR.use_cassette("workspace-info") do
        workspace = Slack::Workspace.new
        name_or_id = "random"
        
        channel = workspace.select(name_or_id)
        expect(channel).must_be_kind_of String
      end
    end
    
    it "returns a string for a matching user ID" do
      VCR.use_cassette("workspace-info") do
        workspace = Slack::Workspace.new
        name_or_id = "USLACKBOT"
        
        user = workspace.select(name_or_id)
        expect(user).must_be_kind_of String
      end
    end 
    
    it "returns a string for a matching channel ID" do
      VCR.use_cassette("workspace-info") do
        workspace = Slack::Workspace.new
        name_or_id = "CMUR2JTNX"
        
        user = workspace.select(name_or_id)
        expect(user).must_be_kind_of String
      end
    end 
    
    it "returns nil for non-matching input" do
      VCR.use_cassette("workspace-info") do
        workspace = Slack::Workspace.new
        name_or_id = "nonexistentname"
        user = workspace.select(name_or_id)
        assert_nil user
      end 
    end 
  end
  
  describe "show details" do  
    it "returns a table for the selected user or channel" do
      VCR.use_cassette("workspace-info") do
        workspace = Slack::Workspace.new
        name_or_id = "random"
        @selected = workspace.select(name_or_id)
        expect(workspace.show_details).must_be_kind_of TablePrint::Returnable
      end
    end
    
  end
  
  describe "user_message" do  
    it "returns a message string when a message is sent successfully" do
      VCR.use_cassette("workspace-info") do
        workspace = Slack::Workspace.new
        name_or_id = "random"
        @selected = workspace.select(name_or_id)
        message = "The bots are pleased."
        slack_id = "CMUR2JTNX"
        expect(workspace.user_message(message, slack_id)).must_equal 
        String
      end
    end
    
  end
  
end