require_relative 'test_helper'

describe "Workspace" do
  describe "initialize" do
    before do
      VCR.use_cassette("new_workspace") do
        @new_workspace = SlackCLI::Workspace.new
      end
    end
    it "can initialize" do
      expect(@new_workspace).must_be_instance_of SlackCLI::Workspace
    end

    it "stores instances of User in @users" do
      expect(@new_workspace.users.first).must_be_instance_of SlackCLI::User
    end


  end
  
end
