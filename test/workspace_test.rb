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
  
  describe "find_instance" do
    it "finds a User given their Slack Id or Name" do
      id = "USLACKBOT"
      user_1 = @new_workspace.find_instance(@new_workspace.users, id)

      name = "Slackbot"
      user_2 = @new_workspace.find_instance(@new_workspace.users, name)

      expect(user_1).must_be_instance_of SlackCLI::User
      expect(user_1.slack_id.downcase).must_equal id.downcase

      expect(user_2).must_be_instance_of SlackCLI::User
      expect(user_2.name.downcase).must_equal name.downcase
    end

    it "finds a User even if the case doesn't match" do
      id = "uslackBOT"
      user_1 = @new_workspace.find_instance(@new_workspace.users, id)

      name = "sLacKbOt"
      user_2 = @new_workspace.find_instance(@new_workspace.users, name)

      expect(user_1).must_be_instance_of SlackCLI::User
      expect(user_1.slack_id.downcase).must_equal id.downcase

      expect(user_2).must_be_instance_of SlackCLI::User
      expect(user_2.name.downcase).must_equal name.downcase
    end

    it "returns nil if user is not found" do
      name = "mr. slackbot"
      user = @new_workspace.find_instance(@new_workspace.users, name)

      expect(user).must_be_nil
    end
  end

end
