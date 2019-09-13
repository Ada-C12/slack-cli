require_relative 'test_helper'


describe "SlackCLI::Workspace" do
  
  describe "select_user" do
    it "should assign selected user to @selected and raise SlackCLI Error if it doesn't exist " do
      VCR.use_cassette("select_user") do
        @user_workspace = SlackCLI::Workspace.new
        @user_workspace.select_user(user_name: "slackbot")
      end
      expect(@user_workspace.selected).must_be_instance_of SlackCLI::User
      expect(@user_workspace.selected.user_name).must_equal "slackbot"
      expect{@user_workspace.select_user(slack_id: "0")}.must_raise SlackApiError
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
      expect{@channel_workspace.select_channel(slack_id: "12")}.must_raise SlackApiError
    end
  end
  
  describe "send_message" do
    it "sends message to channel if exists" do
      VCR.use_cassette("send_channel_message") do
        @channel_workspace = SlackCLI::Workspace.new
        @channel_workspace.select_channel(name: "random")
        expect(@channel_workspace.send_message("hey")["ok"]).must_equal true
      end
    end
    it "sends message to user if exists" do
      VCR.use_cassette("send_channel_message") do
        @user_workspace = SlackCLI::Workspace.new
        @user_workspace.select_user(user_name: "nataliemtapias")
        expect(@user_workspace.send_message("hey")["ok"]).must_equal true
      end
    end
    it "should raise SlackApiError" do
      VCR.use_cassette("send_channel_message") do
        @user_workspace = SlackCLI::Workspace.new
        expect{ @user_workspace.select_user(user_name: "joe_schmoe")
          @user_workspace.send_message("hey")["ok"]}.must_raise SlackApiError
        end
      end
    end
  end
  