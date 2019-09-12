require_relative 'test_helper'

describe "Workspace" do
  before do
    VCR.use_cassette("new_workspace") do
      @new_workspace = SlackCLI::Workspace.new
    end
  end

  describe "initialize" do
    it "can initialize" do
      expect(@new_workspace).must_be_instance_of SlackCLI::Workspace
    end

    it "stores instances of User in @users" do
      expect(@new_workspace.users.first).must_be_instance_of SlackCLI::User
    end
  end
  
  describe "find_user" do
    it "finds a User given their Slack Id or Name" do
      id = "USLACKBOT"

      user = @new_workspace.find_user(id)

      expect(user).must_be_instance_of SlackCLI::User
      expect(user.slack_id).must_equal id
    end
  end

end
