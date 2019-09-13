require_relative 'test_helper'
require 'pry'

describe "Workspace class" do
  before do
    VCR.use_cassette("workspace") do
      @workspace = Workspace.new
    end
  end

  describe "initializer" do
    it "can create an instance" do

      expect(@workspace).must_be_instance_of Workspace
    end

    it "establishes the base data structures when instantiated" do 

      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.channels).must_be_kind_of Array
    end

  describe "get_users method" do
    it "can return user data from Slack API" do
      
      users = @workspace.users
    
      expect(users[0].id).must_equal "USLACKBOT"
      expect(users[0].name).must_equal "slackbot"
      expect(users[0].real_name).must_equal "Slackbot"
    end
  end

  describe "get_channels method" do
    it "can return channel data from Slack API" do
      
      channels = @workspace.channels
  
      expect(channels[2].id).must_equal "CN9N9ECF8"
      expect(channels[2].name).must_equal "random"
      expect(channels[2].topic).must_equal "Non-work banter and water cooler conversation"
      expect(channels[2].member_count).must_equal 2

    end
  end

  describe "select_user method" do
    it "can return a valid user from list based on user input" do
        VCR.use_cassette("workspace") do
          workspace = Workspace.new
        
        user = workspace.select_user("slackbot")

        expect(user[0]).must_be_instance_of User
      end
    end

  end

  describe "select_channel method" do
    it "can return a valid channel from list based on user input" do
      VCR.use_cassette("workspace") do
        workspace = Workspace.new

        channel = workspace.select_channel("random")

        expect(channel[0]).must_be_instance_of Channel
      end
    end
  end
end
end
