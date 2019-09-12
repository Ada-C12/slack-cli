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

  describe "workspace channel list methods" do
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
      it "will search through usernames and save that user to selected" do
        workspace = Slack::Workspace.new
        VCR.use_cassette("workspace_user") do 
          workspace.user_list
          workspace.search("user", "slackbot")
        end
        workspace.print_user_list
        expect(workspace.selected).must_be_instance_of Slack::User
        expect(workspace.selected.username).must_equal "slackbot"
      end

      it "if username does not exist it will set the value of @selected to nil" do
        workspace = Slack::Workspace.new
        VCR.use_cassette("workspace_user") do 
          workspace.user_list
          workspace.search("user", "slackboot")
        end
        p workspace.print_user_list
        expect(workspace.selected).must_be_nil
      end
      
      it "will search through user slack_ids and save that user to selected" do
        workspace = Slack::Workspace.new
        VCR.use_cassette("workspace_user") do 
          workspace.user_list
          workspace.search("user", "USLACKBOT")
        end
        workspace.print_user_list
        expect(workspace.selected).must_be_instance_of Slack::User
        expect(workspace.selected.slack_id).must_equal "USLACKBOT"
      end

      it "if slack_id does not exist it will set the value of @selected to nil" do
        workspace = Slack::Workspace.new
        VCR.use_cassette("workspace_user") do 
          workspace.user_list
          workspace.search("user", "USLACKBOOT")
        end
        workspace.print_user_list
        expect(workspace.selected).must_be_nil
      end

      describe ".search channels" do
        it "will search through channels and save that channel to selected" do
  
        end
      end




    end
  end
  
  describe "Workspace show details methods" do
    describe ".show_details for user" do 
      it "will print the details of the selected user" do
        workspace = Slack::Workspace.new
        VCR.use_cassette("workspace_user") do 
          workspace.user_list
          workspace.search("user", "USLACKBOT")
          @selected = workspace.users[0]
        end
        expect(workspace.show_details(@selected)).must_be_kind_of String
      end

    end

    describe ".show_details for channel" do
      it "will print the details of the selected channel" do
        # 
      end
    end
    
  end
 


  





    
    
    

end