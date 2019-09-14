require_relative 'test_helper'

describe "Workspace class" do
  describe "New instance of Slack::Workspace" do 
    before do 
      VCR.use_cassette("new_workspace") do
        @workspace = Slack::Workspace.new
      end
    end
    
    it "is of the class Slack::Workspace" do 
      expect(@workspace.class).must_equal (Slack::Workspace) 
    end
    
    it "has users" do 
      expect(@workspace.users.length).must_equal 8
    end
  end #end of first block
  
  describe "selects target" do 
    before do 
      VCR.use_cassette("select") do 
        @workspace = Slack::Workspace.new
        @user_slack_id = "UMTG0S5D0"
        @user_user_name = "samantha.collares"
        @channel_slack_id = "CMUR2JTNX"
        @channel_user_name = "random"
      end
    end
    
    it "selects user by slack_id" do 
      expect(@workspace.select_user_slack_id(slack_id: @user_slack_id)).must_be_kind_of Slack::User
    end
    
    it "selects user by user_name" do 
      expect(@workspace.select_user_username(user_name: @user_user_name)).must_be_kind_of Slack::User
    end
    
    it "selects channel by slack_id" do 
      expect(@workspace.select_channel_slack_id(slack_id: @channel_slack_id)).must_be_kind_of Slack::Channel
    end
    
    it "selects user by user_name" do 
      expect(@workspace.select_channel_username(user_name: @channel_user_name)).must_be_kind_of Slack::Channel
    end
  end #select target
  
  describe "show details" do 
    before do 
      VCR.use_cassette("details") do 
        @workspace = Slack::Workspace.new
        @workspace.select_user_slack_id(slack_id: "UN5R3NYUU")
      end
    end
    
    it "shows user details" do 
      expect(@workspace.show_details).must_be_kind_of Hash
    end
  end #show detals
  
  describe "send a message" do 
    it "sends a message to the channel" do 
      VCR.use_cassette("details") do 
        @workspace = Slack::Workspace.new
        @workspace.select_channel_slack_id(slack_id: "CMUR2JTNX")
        @response = @workspace.send_message("hi!")
      end
      
      expect(@response).must_equal true
    end
    
    it "sends a message to the channel" do 
      VCR.use_cassette("details") do 
        @workspace = Slack::Workspace.new
        @workspace.select_channel_slack_id(slack_id: "HASFHAS")
      end
      
      expect{
        @workspace.send_message("hi!")}.must_raise StandardError
      end
      
      it "sends a message to the user" do 
        VCR.use_cassette("info") do 
          @workspace = Slack::Workspace.new
          @workspace.select_user_slack_id(slack_id: "UMTG0S5D0")
          @response = @workspace.send_message("hi!")
        end
        
        expect(@response).must_equal true
      end
      
      it "sends a message to the channel" do 
        VCR.use_cassette("info") do 
          @workspace = Slack::Workspace.new
          @workspace.select_user_slack_id(slack_id: "HASFHAS")
        end
        
        expect{
          @workspace.send_message("hi!")}.must_raise StandardError
        end
        
        
        
      end # send message
      
    end #overall 