require_relative 'test_helper'

describe "Workspace" do
  describe "initialize" do
    it "can be initialized" do 
        workspace = Slack::Workspace.new
        # response = Slack::User.get_api
      expect(workspace).must_be_kind_of Slack::Workspace
    end






  end
end