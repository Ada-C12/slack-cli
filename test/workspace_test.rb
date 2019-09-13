require_relative 'test_helper'

describe "Workspace" do
  before do
    VCR.use_cassette("new_workspace") do
      @new_workspace = SlackCLI::Workspace.new
    end
  end
  
  describe "initialize" do
    it "can initialize" do
      expect(@new_workspace).must_be_instance_of SlackCLI::Workspace
    end
    
    it "stores instances of User in @users" do
      expect(@new_workspace.users.first).must_be_instance_of SlackCLI::User
    end
  end
  
  describe "find_instance" do
    it "finds a User given their Slack Id or Name" do
      id = "USLACKBOT"
      user_1 = @new_workspace.find_instance(@new_workspace.users, id)
      
      name = "Slackbot"
      user_2 = @new_workspace.find_instance(@new_workspace.users, name)
      
      expect(user_1).must_be_instance_of SlackCLI::User
      expect(user_1.slack_id.downcase).must_equal id.downcase
      
      expect(user_2).must_be_instance_of SlackCLI::User
      expect(user_2.name.downcase).must_equal name.downcase
    end
    
    it "finds a User even if the case doesn't match" do
      id = "uslackBOT"
      user_1 = @new_workspace.find_instance(@new_workspace.users, id)
      
      name = "sLacKbOt"
      user_2 = @new_workspace.find_instance(@new_workspace.users, name)
      
      expect(user_1).must_be_instance_of SlackCLI::User
      expect(user_1.slack_id.downcase).must_equal id.downcase
      
      expect(user_2).must_be_instance_of SlackCLI::User
      expect(user_2.name.downcase).must_equal name.downcase
    end
    
    it "returns nil if user or channel is not found" do
      name = "mr. slackbot"
      channel_name = "not a channel"
      user = @new_workspace.find_instance(@new_workspace.users, name)
      channel = @new_workspace.find_instance(@new_workspace.channels, channel_name)
      
      expect(user).must_be_nil
      expect(channel).must_be_nil
    end
    
    it "finds a channel given the channel name or id" do
      id = "CN9NG0YUE"
      channel_1 = @new_workspace.find_instance(@new_workspace.channels, id)
      
      name = "random"
      channel_2 = @new_workspace.find_instance(@new_workspace.channels, name)
      
      expect(channel_1).must_be_instance_of SlackCLI::Channel
      expect(channel_1.slack_id.downcase).must_equal id.downcase
      
      expect(channel_2).must_be_instance_of SlackCLI::Channel
      expect(channel_2.name.downcase).must_equal name.downcase
    end
  end
  
  describe "select_user" do
    before do
      @new_workspace.selected == nil
    end
    
    it "assigns a User to selected" do
      before_selected = @new_workspace.selected
      user_1_name = "Slackbot"
      
      selection = @new_workspace.select_user(user_1_name)
      
      expect(before_selected).must_be_nil
      expect(@new_workspace.selected).must_equal selection
    end
  end

  describe "select_channel" do
    before do
      @new_workspace.selected == nil
    end
    
    it "assigns a Channel to selected" do
      before_selected = @new_workspace.selected
      channel_1_name = "random"
      
      selection = @new_workspace.select_channel(channel_1_name)
      
      expect(before_selected).must_be_nil
      expect(@new_workspace.selected).must_equal selection
    end

    it "reassigns a Channel to selected" do
      old_selection = @new_workspace.select_channel("general")
      new_selection = @new_workspace.select_channel("random")

      expect(@new_workspace.selected).wont_equal old_selection
      expect(@new_workspace.selected.name).must_equal "random"
    end
  end

  describe "show_details" do
    it "returns details for a selected recipient" do
      VCR.use_cassette("get_user_info") do
        channel_id = "CN9NG0YUE"
        user_id = "USLACKBOT"

        @new_workspace.select_channel(channel_id)
        details_1 = @new_workspace.show_details
        @new_workspace.select_user(user_id)
        details_2 = @new_workspace.show_details

        expect(details_1).must_include "random"
        expect(details_2).must_include "slackbot"
      end
    end

    it "returns nil if no user or channel is selected" do
      @new_workspace.selected == nil

      expect(@new_workspace.show_details).must_be_nil
    end
  end

  describe "send_message" do
    it "returns true if a message was sent" do
      channel_random = @new_workspace.find_instance(@new_workspace.channels, "random")
      @new_workspace.selected = channel_random
      
      VCR.use_cassette("workspace_send_message") do
        response = @new_workspace.send_message("trying to send from workspace_test")
        expect(response).must_equal true
      end
    end

  end
end
