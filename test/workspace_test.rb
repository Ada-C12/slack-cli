require_relative 'test_helper'

describe "Workspace" do
  describe "initialize" do
    it "can be initialized" do 
        workspace = Slack::Workspace.new
        workspace.user_list

        # response = Slack::User.get_api
      expect(workspace).must_be_kind_of Slack::Workspace
      expect(workspace.users).must_be_kind_of Array
      expect(workspace.users[0]).must_be_kind_of Slack::User
    
    end






  end
end