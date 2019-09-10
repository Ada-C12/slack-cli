require_relative 'test_helper'

describe "Workspace" do
  describe "initialize" do
    it "can initialize" do
      new_workspace = SlackCLI::Workspace.new

      expect(new_workspace).must_be_instance_of SlackCLI::Workspace
    end
  end
  


end
