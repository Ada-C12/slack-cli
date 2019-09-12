require_relative "test_helper"

describe "Class Workspace" do
  it "is an instance of Workspace" do 
    workspace = Slack::Workspace.new([], [], [])
    expect(workspace).must_be_kind_of Slack::Workspace
  end
  
  it "checks data structures at initialize" do
    workspace = Slack::Workspace.new([], [], [])
    expect(workspace.users).must_be_kind_of Array
  end
end 
