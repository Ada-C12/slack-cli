require_relative "test_helper"

describe "Workspace class" do
  
  describe "Initialize Workspace" do
    before do
      VCR.use_cassette("workspace") do
        @workspace = SlackCLI::Workspace.new
      end
    end
    
    it "Creates a new workspace" do
      expect(@workspace).must_be_instance_of SlackCLI::Workspace
    end
    
    it "Generates an array of users" do
      expect(@workspace.users).must_be_instance_of Array
      expect(@workspace.users.first).must_be_instance_of SlackCLI::User
    end
    
    it "Generates an array of channels" do
      expect(@workspace.channels).must_be_instance_of Array
      expect(@workspace.channels.first).must_be_instance_of SlackCLI::Channel
    end
    
    it "initializes selected as nil" do
      expect(@workspace.selected).must_be_nil
    end
  end
end

