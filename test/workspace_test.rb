require_relative "test_helper"

describe "Class Workspace" do
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
