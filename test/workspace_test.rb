require_relative 'test_helper'

describe Workspace do
  before do
    VCR.use_cassette('workspace') do
      @workspace = Workspace.new
    end
  end
  
  describe 'Constructor' do
    it 'can create a Workspace instance' do
      expect(@workspace).must_be_instance_of Workspace
    end
    
    it 'has users, channels and selected' do
      expect(@workspace.channels).must_be_instance_of Array
      expect(@workspace.users).must_be_instance_of Array
      assert_nil(@workspace.selected)
    end
    
    it 'populates users and channels' do
      expect(@workspace.channels.first).must_be_instance_of Channel
      expect(@workspace.users.first).must_be_instance_of User
    end
  end
  
  describe '#select_channel' do
    
  end
  
  describe '#select_user' do
    
  end
  
  describe '#send_message' do
    
  end
  
  describe "#find_recipient" do
    before do
      @user_name = "calopter"
      @user_id = "UN8G3G4VC"
      @users = @workspace.users

      @channel_name = "random"
      @channel_id = "CMURJLBUK"
      @channels = @workspace.channels
    end
    it "returns the correct User by slack id or name" do
      user = @workspace.find_recipient(list: @users, name: @user_name)
      
      expect (user).must_be_instance_of User
      expect (user.slack_id).must_equal @user_id

      user = @workspace.find_recipient(list: @users, slack_id: @user_id)
      
      expect (user).must_be_instance_of User
      expect (user.name).must_equal @user_name
    end
    
    it "returns the correct Channel by slack id or name" do
      channel = @workspace.find_recipient(list: @channels, name: @channel_name)
      
      expect (channel).must_be_instance_of Channel
      expect (channel.slack_id).must_equal @channel_id

      channel = @workspace.find_recipient(list: @channels, slack_id: @channel_id)
      
      expect (channel).must_be_instance_of Channel
      expect (channel.name).must_equal @channel_name
    end

    it "raises ArgumentError if both name and slack id aren't provided" do
      expect {@workspace.find_recipient(list: [])}.must_raise ArgumentError
    end
    
    it "returns nil if no recipient found from name or slack id" do
      assert_nil (@workspace.find_recipient(list: @channels, name: "Tofu"))
      assert_nil (@workspace.find_recipient(list: @users, slack_id: "Tofu"))
    end
  end
end
