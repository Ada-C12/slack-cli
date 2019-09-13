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

  describe "error cases" do
    before do
      VCR.use_cassette("workspace_find_channel_by_id_error") do
        @workspace = Workspace.new
      end
    end

    it "attempts to find a channel whose id does not exist" do
      expect { @workspace.find_by_id_or_name("channel", "IDONTEXIST") }.must_raise ArgumentError
    end

    it "attempts to find a user whose id does not exist" do
      expect { @workspace.find_by_id_or_name("user", "IDONTEXIST") }.must_raise ArgumentError
    end
  end
  describe "instantiate a channel" do
    before do
      @channel = Channel.new("https://slack.com/api/conversations.list", ENV["SLACK_TOKEN"])
      Channel.load_all
    end
  end
  describe "find_by_id_or_name" do
    before do
      VCR.use_cassette("channel_find_by_id_or_name") do
        @workspace = Workspace.new
      end
    end

    it "retrieves the correct channel matching the id" do
      channel = nil

      channel = @workspace.find_by_id_or_name("channel", "CN85SCME3")

      expect(channel).must_be_instance_of Channel
      expect(channel.name).must_equal "slack-cli"
    end
  end

  describe "list_details_on_current_recipient" do
    before do
      VCR.use_cassette("list_details_on_current_recipient") do
        @workspace = Workspace.new
      end
    end
    it "raises an argument error when no receipient is selected" do
      expect { @workspace.list_details_on_current_recipient }.must_raise ArgumentError
    end
    it "gets details on a selected recipient" do
      channel = @workspace.find_by_id_or_name("channel", "CN85SCME3")
      expect(@workspace.list_details_on_current_recipient).must_be_instance_of Channel
    end
  end

  describe "find_by_id_or_name" do
    before do
      VCR.use_cassette("user_find_by_id_or_name") do
        @workspace = Workspace.new
      end
    end

    it "retrieves the correct user matching the id" do
      user = nil

      user = @workspace.find_by_id_or_name("user", "UMURH3TBM")

      expect(user).must_be_instance_of User
      expect(user.username).must_equal "m.dove"
    end
    it "raises an agument error if either a channel or user is not selected" do
      expect { @workspace.find_by_id_or_name("otter", "UMURH3TBM") }.must_raise ArgumentError
    end
  end
  describe "send_message" do
    before do
      VCR.use_cassette("send_message") do
        @workspace = Workspace.new
        @message_url = @workspace.message_url
        @test_message = HTTParty.post(@message_url,
                                      headers: { "Content-Type" => "application/x-www-form-urlencoded" },
                                      body: {
                                        "token" => ENV["SLACK_TOKEN"],
                                        "channel" => "random",
                                        "text" => "POTTYMOUTH",
                                      })
      end
    end
    it "can send a message with given text" do
      expect @test_message["message"]["text"].must_equal "POTTYMOUTH"
    end
    it "allows for inclusion of a cat_block" do
      VCR.use_cassette("send_message") do
        @workspace.find_by_id_or_name("channel", "random")
        @sent_message = @workspace.send_message("MEOWMEOW", "yes")
      end
      expect @sent_message["message"]["blocks"][0]["image_url"].must_include "MEOWMEOW"
      expect @workspace.current_recipient.name.must_equal "random"
    end
  end
end
