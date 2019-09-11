require_relative 'test_helper'

describe "Workspace" do
  describe "initialize" do
    it "can be initialized" do 
      workspace = Slack::Workspace.new
      # VCR.use_cassette("workspace_user") do 
      #   @response = workspace.user_list
      # end
      expect(workspace).must_be_kind_of Slack::Workspace
    end
  end

  describe "workspace methods" do
    describe "get_api" do
      it "returns a response from Slack api" do
        workspace = Slack::Workspace.new
        VCR.use_cassette("workspace_user") do 
          @response = workspace.get_api("https://slack.com/api/users.list")
        end
      expect(@response).must_be_kind_of HTTParty::Response
      end
    end





  end
end