require_relative "test_helper"

describe "workspace" do
  describe "list_users" do
    before do
      VCR.use_cassette("workspace_get_users_test") do
        @workspace = Workspace.new

        @users = @workspace.get_users
      end
    end
    it "retrieves the correct number of users in a workspace" do
      expect(@users.length).must_equal 3
    end
    it "gets the usernames of all the users" do
      expect(@users[0].username).must_equal "slackbot"
      expect(@users[1].username).must_equal "m.dove"
      expect(@users[2].username).must_equal "kelseykripp"
    end
    it "gets the real names of all the users" do
      expect(@users[0].name).must_equal "Slackbot"
      expect(@users[1].name).must_equal "Mackie Dove"
      expect(@users[2].name).must_equal "Kelsey Kripp"
    end
  end
  describe "list_channels" do
    before do
      VCR.use_cassette("workspace_list_channels_test") do
        @workspace = Workspace.new

        @channels = @workspace.list_channels
      end
    end

    it "retrieves the correct number of channels in a workspace" do
      expect(@channels.length).must_equal 3
    end
  end
  describe "list_users" do
    before do
      VCR.use_cassette("workspace_list_users_test") do
        @workspace = Workspace.new

        @users = @workspace.list_users
      end
    end

    it "retrieves the correct number of users in the workspace" do
      expect(@users.length).must_equal 3
    end
  end

  describe "find_by_id" do
    before do
      VCR.use_cassette("workspace_find_by_id") do
        @workspace = Workspace.new
      end
    end

    it "retrieves the correct recipie t matching the id" do
      user = nil

      user = @workspace.find_by_id("UMURH3TBM")

      expect(user).must_be_instance_of User
      expect(user.username).must_equal "m.dove"
    end
  end

  # describe "find_channel_by_id" do
  #   before do
  #     VCR.use_cassette("workspace_find_channel_by_id") do
  #       @workspace = Workspace.new
  #     end
  #   end

  #   it "retrieves the correct channel matching the id" do
  #     channel = nil

  #     channel = @workspace.find_channel_by_id("CN85SCME3")

  #     expect(channel).must_be_instance_of Channel
  #     expect(channel.name).must_equal "slack-cli"
  #   end
  # end

  describe "error cases" do
    before do
      VCR.use_cassette("workspace_find_channel_by_id_error") do
        @workspace = Workspace.new
      end

      it "tries to instantiate a recipient object" do
        expect { Recipient.load_all("url", "token") }.must_raise ArgumentError
      end

      it "attempts to find a channel whose id does not exist" do
        expect { @workspace.find_channel_by_id("IDONTEXIST") }.must_raise ArgumentError
      end
    end

    it "attempts to find a user whose id does not exist" do
      expect { @workspace.find_user_by_id("IDONTEXIST") }.must_raise ArgumentError
    end
  end
end
