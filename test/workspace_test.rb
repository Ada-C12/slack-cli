require_relative 'test_helper'
require 'pry'

describe "Workspace" do
  describe "intialize" do
    it "creates a new instance of workspace" do
      VCR.use_cassette("create_workspace") do
        workspace = Workspace.new
        
        expect(workspace).must_be_kind_of Workspace
      end
    end
    
    it "contains an array of all users" do
      VCR.use_cassette("create_workspace") do
        workspace = Workspace.new
        
        expect(workspace.users).must_be_kind_of Array
        expect(workspace.users.length).must_equal 3
        expect(workspace.users[0]).must_be_kind_of User
      end
    end
    
    it "contains an array of all channels" do
      VCR.use_cassette("create_workspace") do
        workspace = Workspace.new
        
        expect(workspace.channels).must_be_kind_of Array
        expect(workspace.channels.length).must_equal 3
        expect(workspace.channels[0]).must_be_kind_of Channel
      end
    end
  end
  
  describe "select users" do
    it "selects the correct user" do
      VCR.use_cassette("create_workspace") do
        workspace = Workspace.new
        workspace.select_user("kemp.bri")
        
        expect(workspace.selected).must_be_kind_of User
        expect(workspace.selected.name).must_equal "kemp.bri"
        expect(workspace.selected.slack_id).must_equal "UMUR2C1QB"
      end
    end
    
    it "selects the correct user" do
      VCR.use_cassette("create_workspace") do
        workspace = Workspace.new
        workspace.select_user("UMUR2C1QB")
        
        expect(workspace.selected).must_be_kind_of User
        expect(workspace.selected.name).must_equal "kemp.bri"
        expect(workspace.selected.slack_id).must_equal "UMUR2C1QB"
      end
    end
    
    it "returns message if user is not found" do
      VCR.use_cassette("create_workspace") do
        workspace = Workspace.new
        result = workspace.select_user("aerstdhsg")
        
        expect(result).must_be_kind_of String
        expect(result.length).must_equal 19
      end
    end
  end
  
  describe "select channel" do
    it "selects the correct channel" do
      VCR.use_cassette("create_workspace") do
        workspace = Workspace.new
        workspace.select_channel("general")
        
        expect(workspace.selected).must_be_kind_of Channel
        expect(workspace.selected.name).must_equal "general"
        expect(workspace.selected.slack_id).must_equal "CMTFYSFTL"
      end
    end
    
    it "selects the correct channel" do
      VCR.use_cassette("create_workspace") do
        workspace = Workspace.new
        workspace.select_channel("CMTFYSFTL")
        
        expect(workspace.selected).must_be_kind_of Channel
        expect(workspace.selected.name).must_equal "general"
        expect(workspace.selected.slack_id).must_equal "CMTFYSFTL"
      end
    end
    
    it "returns message if channel is not found" do
      VCR.use_cassette("create_workspace") do
        workspace = Workspace.new
        result = workspace.select_channel("hgfdghf")
        
        expect(result).must_be_kind_of String
        expect(result.length).must_equal 22
      end
    end
  end
  
  describe "show details" do
    it "shows details for selected user" do
      VCR.use_cassette("create_workspace") do
        workspace = Workspace.new
        workspace.select_user("kemp.bri")
        details = workspace.show_details
        
        expect(details).must_be_kind_of String
        expect(details.length).must_equal 103
      end
    end
    
    it "shows details for selected channel" do
      VCR.use_cassette("create_workspace") do
        workspace = Workspace.new
        workspace.select_channel("general")
        details = workspace.show_details
        
        expect(details).must_be_kind_of String
        expect(details.length).must_equal 126
      end
    end
    
    it "returns message for non-selected user/channel" do
      VCR.use_cassette("create_workspace") do
        workspace = Workspace.new
        workspace.select_channel("sshtirl")
        details = workspace.show_details
        
        expect(details).must_be_kind_of String
        expect(details.length).must_equal 32
      end
    end
  end
end
