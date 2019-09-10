require_relative 'test_helper'

describe "Workspace" do
  before do
    VCR.use_cassette("user_tests") do      
      @workspace = Slack::Workspace.new
    end
  end
  
  it "is an instance of Workspace" do
    expect(@workspace).must_be_kind_of Slack::Workspace
  end
  
  it "creates a workspace with a list of users, a list of channels" do
    expect(@workspace.users).must_be_kind_of Array
    expect(@workspace.users.length).must_equal 7
    expect(@workspace.channels).must_be_kind_of Array
    expect(@workspace.channels.length).must_equal 3
    expect(@workspace.selected).must_be_nil
  end
  
  # do we need a test for lists_users  or list_channels? currently can't test because we are putsing
  it "lists users" do
  end
end

