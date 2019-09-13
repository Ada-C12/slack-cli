require_relative 'test_helper'


describe "SlackCLI::Workspace" do
  
  before do
    VCR.use_cassette("select_user") do
      @new_workspace = SlackCLI::Workspace.new
      @new_workspace.select_user(user_name: "slackbot")
    end
  end
  describe "select_user" do
    it "should assign selected user to @selected " do
      expect(@new_workspace.selected).must_be_instance_of SlackCLI::User
      expect(@new_workspace.selected.user_name).must_equal "slackbot"
    end
    
  end
  
end
