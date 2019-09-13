require_relative 'test_helper'

describe "Workspace" do
  before do
    VCR.use_cassette("workspace_test") do      
      @workspace = Slack::Workspace.new
    end
  end
  
  describe "constructor" do
    it "is an instance of Workspace" do
      expect(@workspace).must_be_kind_of Slack::Workspace
    end
    
    it "creates a workspace with a list of users, a list of channels" do
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.users.length).must_equal 7
      expect(@workspace.channels).must_be_kind_of Array
      expect(@workspace.channels.length).must_equal 4
      expect(@workspace.selected).must_be_nil
    end
  end
  
  # do we need a test for lists_users  or list_channels? currently can't test because we are putsing
  # it "lists users" do
  # end
  
  describe "select user" do
    before do
      @requested_user = "alicesunhi"
      @found_user = @workspace.select_user(@requested_user)
    end
    
    it "will return a found user that matches" do
      expect(@found_user).must_be_kind_of Slack::User
      expect(@found_user.name).must_equal @requested_user
    end
    
    it "will return empty array if no matching user" do
      invalid_user = "random"
      expect(@workspace.select_user(invalid_user)).must_be_nil
    end
    
    it "will assign found user to 'selected' instance variable" do
      expect(@workspace.selected).must_equal @found_user
    end
  end
  
  describe "select channel" do
    before do
      @requested_channel = "general"
      @found_channel = @workspace.select_channel(@requested_channel)
    end
    
    it "will return a found user that matches" do
      expect(@found_channel).must_be_kind_of Slack::Channel
      expect(@found_channel.name).must_equal @requested_channel
    end
    
    it "will return empty array if no matching user" do
      invalid_channel = "nothing"
      expect(@workspace.select_channel(invalid_channel)).must_be_nil
    end
    
    it "will assign found user to 'selected' instance variable" do
      expect(@workspace.selected).must_equal @found_channel
    end
  end
  
  describe "send_message" do
    it "can send valid message" do
      @workspace.select_user("alicesunhi")
      
      VCR.use_cassette("workspace_test") do
        response = @workspace.send_message("This is my message text")
        
        expect(response).must_equal true
      end
    end
    
    it "will raise an error when invalid message text" do
      @workspace.select_user("alicesunhi")
      
      VCR.use_cassette("workspace_test") do
        rename = expect{
          @workspace.send_message(nil)
        }.must_raise SlackApiError
        
        expect(rename.message).must_equal"Error when sending message to alicesunhi. Invalid API request with code 200 and message no_text."
      end
    end
    
    #should we create a slack No Method Error for this case?
    it "will raise an error when no selected user or channel" do
      VCR.use_cassette("workspace_test") do
        expect{
          @workspace.send_message("This is my message text")
        }.must_raise NoMethodError
      end
    end
  end
  
  describe "set_profile_name" do
    it "can change profile name" do
      # need to select profile of token to confirm change
      @workspace.select_user("rvesteinsdottir")
      
      VCR.use_cassette("profile_test") do
        response = @workspace.set_profile_name("random_name")
        
        expect(response).must_equal true
      end
      
      expect(@workspace.selected.real_name).must_equal "random_name"
    end
    
    it "raises error if api returns invalid response" do
      VCR.use_cassette("profile_test") do
        expect{
          @workspace.set_profile_name("")
        }.must_raise SlackApiError
      end
    end
  end
  
  describe "set_profile_emoji" do
    before do
      # need to select profile of token to confirm change
      @workspace.select_user("rvesteinsdottir")
    end
    
    it "can change profile emoji" do
      VCR.use_cassette("emoji_test") do
        response = @workspace.set_profile_emoji(":rainbow:")
        
        expect(response).must_equal true
      end
      
      expect(@workspace.selected.status_emoji).must_equal ":rainbow:"
    end
    
    it "raises error if not emoji syntax" do
      VCR.use_cassette("new_emoji") do
        @workspace.set_profile_emoji(":rainbow:")
        
        test_emoji = @workspace.selected.status_emoji
        
        @workspace.set_profile_emoji("cloud")
        
        # emoji will not change if given invalid emoji syntax
        expect(@workspace.selected.status_emoji).must_equal test_emoji
      end
    end
  end
end

