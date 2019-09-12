require_relative 'test_helper'

describe "Workspace" do
  describe "initialize" do
    it "can be initialized" do 
      workspace = Slack::Workspace.new
      expect(workspace).must_be_instance_of Slack::Workspace
    end
  end

  describe "workspace_user list methods" do
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

  describe "workspace_channel list methods" do
    describe "get_api" do
      it "returns a response from Slack api" do
        workspace = Slack::Workspace.new
        VCR.use_cassette("workspace_channel") do 
          @response = workspace.get_api("https://slack.com/api/channels.list")
        end
      expect(@response).must_be_instance_of HTTParty::Response
      end
    end

    describe "channel_list" do
      it "populates the a list of channels inside Workspace" do
        workspace = Slack::Workspace.new
        VCR.use_cassette("workspace_channel") do 
          workspace.channel_list
        end
        expect(workspace.channels).must_be_kind_of Array
        expect(workspace.channels[0]).must_be_instance_of Slack::Channel 
        expect(workspace.channels.length).must_equal 4
      end
    end

    describe "print_channel_list" do
      it "prints a string with channel info" do
        workspace = Slack::Workspace.new
        VCR.use_cassette("workspace_channel") do 
          workspace.channel_list
          @channel_info_string = workspace.print_channel_list
        end
        expect(@channel_info_string).must_be_kind_of String
      end
    end
  end

  describe "Workspace select methods" do
    describe ".search users" do
      it "will search through users and save that user to selected" do
        workspace = Slack::Workspace.new
        VCR.use_cassette("workspace_user") do 
          workspace.user_list
          workspace.search("user", "Slackbot")
        end
        puts workspace.print_user_list
        expect(workspace.selected).must_be_instance_of Slack::User
        expect(workspace.selected.username).must_equal "Slackbot"
      end

      # add test for bad name 
      # add test for bad id
      # add test for good id
  


    end

    describe ".search channels" do
      it "will search through channels and save that channel to selected" do

      end
    end


  end





    
    
    

end