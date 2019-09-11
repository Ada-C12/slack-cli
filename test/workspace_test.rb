require_relative 'test_helper'

describe "Workspace" do
  describe "initialize" do
    it "can be initialized" do 
      workspace = Slack::Workspace.new
      expect(workspace).must_be_instance_of Slack::Workspace
    end
  end

  describe "workspace_user methods" do
    describe "get_api" do
      it "returns a response from Slack api" do
        workspace = Slack::Workspace.new
        VCR.use_cassette("workspace_user") do 
          @response = workspace.get_api("https://slack.com/api/users.list")
        end
      expect(@response).must_be_instance_of HTTParty::Response
      end
    end

    describe "user_list" do
      it "populates the a list of users inside Workspace" do
        workspace = Slack::Workspace.new
        VCR.use_cassette("workspace_user") do 
          workspace.user_list
        end
        expect(workspace.users).must_be_kind_of Array
        expect(workspace.users[0]).must_be_instance_of Slack::User 
        expect(workspace.users.length).must_equal 7
      end
    end

    describe "print_user_list" do
      it "prints a string with user info" do
        workspace = Slack::Workspace.new
        VCR.use_cassette("workspace_user") do 
          workspace.user_list
          @user_info_string = workspace.print_user_list
        end
        expect(@user_info_string).must_be_kind_of String
      end
    end





  end
end