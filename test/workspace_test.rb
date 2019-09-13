require_relative 'test_helper'


describe "SlackCLI::Workspace" do
  
  describe "select_user" do
    it "should assign selected user to @selected " do
      VCR.use_cassette("select_user") do
        @user_workspace = SlackCLI::Workspace.new
        @user_workspace.select_user(user_name: "slackbot")
      end
      
      expect(@user_workspace.selected).must_be_instance_of SlackCLI::User
      expect(@user_workspace.selected.user_name).must_equal "slackbot"
    end
    
  end
  
  describe "select_channel" do
    it "should assign selected channel to @selected " do
      VCR.use_cassette("select_channel") do
        @channel_workspace = SlackCLI::Workspace.new
        @channel_workspace.select_channel(name: "random")
      end
      expect(@channel_workspace.selected).must_be_instance_of SlackCLI::Channel
      expect(@channel_workspace.selected.name).must_equal "random"
    end
  end
  
  
end
